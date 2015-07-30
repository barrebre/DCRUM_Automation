require 'chefspec'
require 'chefspec/berkshelf'

describe 'dcrum_automation::ads_install' do
  let(:chef_run) { ChefSpec::SoloRunner.new }

  it 'creates ads installer' do
    chef_run.converge 'dcrum_automation::ads_install'
    expect(chef_run).to create_remote_file('C:\Dynatrace\ads.exe')
  end

  %w[true (and) false].each do |new_db|
    puts "******#{new_db}"
    if "#{new_db}" == 'true'
      it 'creates new db ADS.properties' do
        chef_run.node.set['dcrum']['common']['new_db'] = 1
        chef_run.converge 'dcrum_automation::ads_install'

        puts '****Entered true block'

        expect(chef_run).to create_template('C:\Dynatrace\ADS.properties').with(
          source: 'ADSNewDB.properties',
          variables: {
            install_dir: 'C:\\\\Program Files\\\\Dynatrace\\\\ADS',
            master_cas: '**Master cas**',
            http_port: 81,
            https_port: 444,
            db_name: 'TESTDB_ADS',
            sql_instance: '**sql Instance**',
            db_size: 10,
            host_name: '**Host Name**',
            sql_admin: '',
            sql_admin_pwd: '',
            sql_all_ram_upgrade: 0
          }
        )
      end
    else
      it 'creates existing db ADS.properties' do
        chef_run.node.set['dcrum']['common']['new_db'] = 0
        chef_run.converge 'dcrum_automation::ads_install'

        puts '****Entered false block'

        expect(chef_run).to create_template('C:\Dynatrace\ADS.properties').with(
          source: 'ADSExistingDB.properties',
          variables: {
            install_dir: 'C:\\\\Program Files\\\\Dynatrace\\\\ADS',
            master_cas: '**Master cas**',
            http_port: 81,
            https_port: 444,
            db_name: 'TESTDB_ADS',
            sql_instance: '**sql Instance**',
            db_size: 10,
            host_name: '**Host Name**',
            sql_admin: '',
            sql_admin_pwd: '',
            sql_all_ram_upgrade: 0
          }
        )
      end
    end
  end

  unless ::File.directory?('C:\\Program Files\\Dynatrace\\ADS')
    it 'installs the ads' do
      chef_run.converge 'dcrum_automation::ads_install'
      expect(chef_run).to run_execute("ads.exe -i silent -f \"ADS.properties\"")
    end
  end
end

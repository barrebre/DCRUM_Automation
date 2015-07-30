require 'chefspec'
require 'chefspec/berkshelf'

describe 'dcrum_automation::cas_install' do
  let(:chef_run) { ChefSpec::SoloRunner.new }

  it 'creates cas installer' do
    chef_run.converge 'dcrum_automation::cas_install'
    expect(chef_run).to create_remote_file('C:\Dynatrace\cas.exe')
  end

  %w[true (and) false].each do |new_db|
    puts "******#{new_db}"
    if "#{new_db}" == 'true'
      it 'creates new db CAS.properties' do
        chef_run.node.set['dcrum']['common']['new_db'] = 1
        chef_run.converge 'dcrum_automation::cas_install'

        puts '****Entered true block'

        expect(chef_run).to create_template('C:\Dynatrace\CAS.properties').with(
          source: 'CASNewDB.properties',
          variables: {
            install_dir: 'C:\\\\Program Files\\\\Dynatrace\\\\CAS',
            http_port: 80,
            https_port: 443,
            db_name: 'TESTDB_CAS',
            host_name: '**Host Name**',
            master_cas: '**Master cas**',
            sql_instance: '**sql Instance**',
            sql_admin: '',
            sql_admin_pwd: '',
            sql_all_ram_upgrade: 0
          }
        )
      end
    else
      it 'creates old db casExistingDB.properties' do
        chef_run.node.set['dcrum']['common']['new_db'] = 0
        chef_run.converge 'dcrum_automation::cas_install'

        puts '****Entered false block'

        expect(chef_run).to create_template('C:\Dynatrace\CAS.properties').with(
          source: 'CASExistingDB.properties',
          variables: {
            install_dir: 'C:\\\\Program Files\\\\Dynatrace\\\\CAS',
            http_port: 80,
            https_port: 443,
            db_name: 'TESTDB_CAS',
            host_name: '**Host Name**',
            master_cas: '**Master cas**',
            sql_instance: '**sql Instance**',
            sql_admin: '',
            sql_admin_pwd: ''
          }
        )
      end
    end
  end

  unless ::File.directory?('C:\\Program Files\\Dynatrace\\CAS')
    it 'installs the cas' do
      chef_run.converge 'dcrum_automation::cas_install'
      expect(chef_run).to run_execute("cas.exe -i silent -f \"CAS.properties\"")
    end
  end
end

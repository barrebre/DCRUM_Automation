require 'chefspec'
require 'chefspec/berkshelf'

describe 'dcrum_automation::rum_install' do
  let(:chef_run) { ChefSpec::SoloRunner.new }

  it 'creates RUM Console installer' do
    chef_run.converge 'dcrum_automation::rum_install'
    expect(chef_run).to create_remote_file('C:\Dynatrace\console.exe')
  end

  it 'creates new db RUM.properties' do
    chef_run.converge 'dcrum_automation::rum_install'
    expect(chef_run).to create_template('C:\Dynatrace\RUM.properties').with(
      source: 'RUM.properties',
      variables: {
        install_dir: 'C:\\\\Program Files\\\\Dynatrace\\\\RUM Console',
        db_name: 'TESTDB_RUM',
        sql_instance: '**sql Instance**',
        new_db: 1,
        existing_db: 0,
        sql_admin: '',
        sql_admin_pwd: ''
      }
    )
  end

  unless ::File.directory?('C:\\\\Program Files\\\\Dynatrace\\\\Common Components')
    it 'installs the css' do
      chef_run.converge 'dcrum_automation::rum_install'
      expect(chef_run).to run_execute("console.exe -i silent -f \"RUM.properties\"")
    end
  end
end

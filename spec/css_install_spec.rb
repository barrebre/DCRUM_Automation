require 'chefspec'
require 'chefspec/berkshelf'

describe 'dcrum_automation::css_install' do
  let(:chef_run) { ChefSpec::SoloRunner.new }

  it 'creates css installer' do
    chef_run.converge 'dcrum_automation::css_install'
    expect(chef_run).to create_remote_file('C:\Dynatrace\css.exe')
  end

  it 'creates new db CSS.properties' do
    chef_run.converge 'dcrum_automation::css_install'
    expect(chef_run).to create_template('C:\Dynatrace\CSS.properties').with(
      source: 'CSS.properties',
      variables: {
        install_dir: 'C:\\\\Program Files\\\\Dynatrace\\\\Common Components',
        db_name: 'TESTDB_CSS',
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
      chef_run.converge 'dcrum_automation::css_install'
      expect(chef_run).to run_execute("css.exe -i silent -f \"CSS.properties\"")
    end
  end
end

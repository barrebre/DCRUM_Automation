#
# Cookbook Name:: dcrum_automation
# Recipe:: css_install
#

# Pull bin file from server
puts 'Copying the css installer from the remote location'
remote_file node['dcrum']['css']['installer'] do
  source node['dcrum']['css']['installer_remote']
  action :create
  not_if { ::File.exist?("#{node['dcrum']['css']['installer']}") }
end

# Creates the Installer.Properties file
puts 'Preparing css Installer.Properties template'
template node['dcrum']['css']['installer_properties'] do
  source 'CSS.properties'
  action :create
  variables(
    install_dir: node['dcrum']['css']['install_dir'],
    db_name: node['dcrum']['css']['db_name'],
    sql_instance: node['dcrum']['common']['sql_instance'],
    new_db: node['dcrum']['common']['new_db'],
    existing_db: node['dcrum']['common']['existing_db'],
    sql_admin: node['dcrum']['common']['sql_admin'],
    sql_admin_pwd: node['dcrum']['common']['sql_admin_pwd']
  )
end

# Installs the css if not in testing mode
unless ::File.directory?("#{node['dcrum']['css']['key_dir']}")
  puts 'Installing the css'
  execute "#{node['dcrum']['css']['file_name']} -i silent -f \"CSS.properties\"" do
    cwd node['dcrum']['common']['dynatrace_loc']
    action :run
  end
end

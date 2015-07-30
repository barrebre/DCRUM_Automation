#
# Cookbook Name:: dcrum_automation
# Recipe:: rum_install
#

# Pull bin file from server
puts 'Copying the rum installer from the remote location'
remote_file node['dcrum']['rum']['installer'] do
  source node['dcrum']['rum']['installer_remote']
  action :create
  not_if { ::File.exist?("#{node['dcrum']['rum']['installer']}") }
end

# Creates the Installer.Properties file
puts 'Preparing rum Installer.Properties template'
template node['dcrum']['rum']['installer_properties'] do
  source 'RUM.properties'
  action :create
  variables(
    install_dir: node['dcrum']['rum']['install_dir'],
    db_name: node['dcrum']['rum']['db_name'],
    sql_instance: node['dcrum']['common']['sql_instance'],
    new_db: node['dcrum']['common']['new_db'],
    existing_db: node['dcrum']['common']['existing_db'],
    sql_admin: node['dcrum']['common']['sql_admin'],
    sql_admin_pwd: node['dcrum']['common']['sql_admin_pwd']
  )
end

# Installs the rum console if not in testing mode
unless ::File.directory?("#{node['dcrum']['rum']['key_dir']}")
  puts 'Installing the RUM Console'
  execute "#{node['dcrum']['rum']['file_name']} -i silent -f \"RUM.properties\"" do
    cwd node['dcrum']['common']['dynatrace_loc']
    action :run
  end
end

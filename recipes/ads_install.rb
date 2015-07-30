#
# Cookbook Name:: dcrum_automation
# Recipe:: amdInstall
#

puts 'Copying the ads installer from the remote location'
# Pull bin file from server
remote_file node['dcrum']['ads']['installer'] do
  source node['dcrum']['ads']['installer_remote']
  action :create
  not_if { ::File.exist?("#{node['dcrum']['ads']['installer']}") }
end

puts 'Preparing ads Installer.Properties template'
# # # # IF EXISTING REMOTE DB
if node['dcrum']['common']['new_db'] == 1
  puts '******Installing with new DB'
  template node['dcrum']['ads']['installer_properties'] do
    source 'ADSNewDB.properties'
    action :create
    variables(
      install_dir: node['dcrum']['ads']['install_dir'],
      master_cas: node['dcrum']['common']['master_cas'],
      http_port: node['dcrum']['ads']['http_port'],
      https_port: node['dcrum']['ads']['https_port'],
      db_name: node['dcrum']['ads']['db_name'],
      sql_instance: node['dcrum']['common']['sql_instance'],
      db_size: node['dcrum']['common']['db_size'],
      host_name: node['dcrum']['common']['host_name'],
      sql_admin: node['dcrum']['common']['sql_admin'],
      sql_admin_pwd: node['dcrum']['common']['sql_admin_pwd'],
      sql_all_ram_upgrade: node['dcrum']['common']['sql_all_ram_upgrade']
    )
  end
else
  template node['dcrum']['ads']['installer_properties'] do
    source 'ADSExistingDB.properties'
    action :create
    variables(
      install_dir: node['dcrum']['ads']['install_dir'],
      master_cas: node['dcrum']['common']['master_cas'],
      http_port: node['dcrum']['ads']['http_port'],
      https_port: node['dcrum']['ads']['https_port'],
      db_name: node['dcrum']['ads']['db_name'],
      sql_instance: node['dcrum']['common']['sql_instance'],
      db_size: node['dcrum']['common']['db_size'],
      host_name: node['dcrum']['common']['host_name'],
      sql_admin: node['dcrum']['common']['sql_admin'],
      sql_admin_pwd: node['dcrum']['common']['sql_admin_pwd'],
      sql_all_ram_upgrade: node['dcrum']['common']['sql_all_ram_upgrade']
    )
  end
end

# Installs the ADS if the directory hasn't been created
unless ::File.directory?("#{node['dcrum']['ads']['key_dir']}")
  puts 'Installing the ads'
  execute "#{node['dcrum']['ads']['file_name']} -i silent -f \"ADS.properties\"" do
    cwd node['dcrum']['common']['dynatrace_loc']
    action :run
  end
end

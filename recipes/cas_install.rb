#
# Cookbook Name:: dcrum_automation
# Recipe:: cas_install
#

puts 'Copying the cas installer from the remote location'
# Pull bin file from server
remote_file node['dcrum']['cas']['installer'] do
  source node['dcrum']['cas']['installer_remote']
  action :create
  not_if { ::File.exist?("#{node['dcrum']['cas']['installer']}") }
end

puts "**Preparing cas Installer.Properties template\n"
puts "******NEW DB = #{node['dcrum']['common']['new_db']}"
# # # # Create properties file based on new or existing DB
if node['dcrum']['common']['new_db'] == 1
  puts '******Installing with new DB'
  template node['dcrum']['cas']['installer_properties'] do
    source 'CASNewDB.properties'
    action :create
    variables(
      install_dir: node['dcrum']['cas']['install_dir'],
      http_port: node['dcrum']['cas']['http_port'],
      https_port: node['dcrum']['cas']['https_port'],
      db_name: node['dcrum']['cas']['db_name'],
      host_name: node['dcrum']['common']['host_name'],
      master_cas: node['dcrum']['common']['master_cas'],
      sql_instance: node['dcrum']['common']['sql_instance'],
      sql_admin: node['dcrum']['common']['sql_admin'],
      sql_admin_pwd: node['dcrum']['common']['sql_admin_pwd'],
      sql_all_ram_upgrade: node['dcrum']['common']['sql_all_ram_upgrade']
    )
  end
else
  puts '******Installing with existing DB'
  template node['dcrum']['cas']['installer_properties'] do
    source 'CASExistingDB.properties'
    action :create
    variables(
      install_dir: node['dcrum']['cas']['install_dir'],
      http_port: node['dcrum']['cas']['http_port'],
      https_port: node['dcrum']['cas']['https_port'],
      db_name: node['dcrum']['cas']['db_name'],
      host_name: node['dcrum']['common']['host_name'],
      master_cas: node['dcrum']['common']['master_cas'],
      sql_instance: node['dcrum']['common']['sql_instance'],
      sql_admin: node['dcrum']['common']['sql_admin'],
      sql_admin_pwd: node['dcrum']['common']['sql_admin_pwd']
    )
  end
end

# Installs the CAS if the directory hasn't been created
unless ::File.directory?("#{node['dcrum']['cas']['key_dir']}")
  puts 'Installing the cas'
  execute "#{node['dcrum']['cas']['file_name']} -i silent -f \"CAS.properties\"" do
    cwd node['dcrum']['common']['dynatrace_loc']
    action :run
  end
end

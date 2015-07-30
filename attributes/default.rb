#
# Cookbook Name:: dcrum_automation
# Attributes:: default
#

# # # Global Attributes (ALWAYS EDITED)
default['dcrum']['common']['master_cas']              = '**Master cas**'
default['dcrum']['common']['sql_instance']            = '**sql Instance**'
default['dcrum']['common']['host_name']               = '**Host Name**'

# # # Global Attributes (Generally static)
default['dcrum']['common']['sql_admin']               = ''
default['dcrum']['common']['sql_admin_pwd']           = ''
default['dcrum']['common']['dcrum_file_permissions']  = 0744
default['dcrum']['common']['remote_loc']              = ''
default['dcrum']['common']['new_db']                  = 1
default['dcrum']['common']['existing_db']             = 0
default['dcrum']['common']['dynatrace_loc']           = 'C:\\Dynatrace'
default['dcrum']['common']['db_size']                 = 10
default['dcrum']['common']['sql_all_ram_upgrade']     = 0

# CAS Attributes
default['dcrum']['cas']['installer_properties'] = "#{node['dcrum']['common']['dynatrace_loc']}\\CAS.properties"
default['dcrum']['cas']['install_dir']          = 'C:\\\\Program Files\\\\Dynatrace\\\\CAS'
default['dcrum']['cas']['key_dir']              = "#{node['dcrum']['cas']['install_dir']}\\server"
default['dcrum']['cas']['file_name']            = 'cas.exe'
default['dcrum']['cas']['installer_remote']     = "#{node['dcrum']['common']['remote_loc']}/#{node['dcrum']['cas']['file_name']}"
default['dcrum']['cas']['installer']            = "#{node['dcrum']['common']['dynatrace_loc']}\\#{node['dcrum']['cas']['file_name']}"
default['dcrum']['cas']['db_name']              = 'TESTDB_CAS'
default['dcrum']['cas']['http_port']            = 80
default['dcrum']['cas']['https_port']           = 443

# ADS Attributes
default['dcrum']['ads']['installer_properties'] = "#{node['dcrum']['common']['dynatrace_loc']}\\ADS.properties"
default['dcrum']['ads']['install_dir']          = 'C:\\\\Program Files\\\\Dynatrace\\\\ADS'
default['dcrum']['ads']['key_dir']              = "#{node['dcrum']['ads']['install_dir']}\\server"
default['dcrum']['ads']['file_name']            = 'ads.exe'
default['dcrum']['ads']['installer_remote']     = "#{node['dcrum']['common']['remote_loc']}/#{node['dcrum']['ads']['file_name']}"
default['dcrum']['ads']['installer']            = "#{node['dcrum']['common']['dynatrace_loc']}\\#{node['dcrum']['ads']['file_name']}"
default['dcrum']['ads']['db_name']              = 'TESTDB_ADS'
default['dcrum']['ads']['http_port']            = 81
default['dcrum']['ads']['https_port']           = 444

# CSS Attributes
default['dcrum']['css']['installer_properties'] = "#{node['dcrum']['common']['dynatrace_loc']}\\CSS.properties"
default['dcrum']['css']['install_dir']          = 'C:\\\\Program Files\\\\Dynatrace\\\\Common Components'
default['dcrum']['css']['key_dir']              = "#{node['dcrum']['css']['install_dir']}\\cc"
default['dcrum']['css']['file_name']            = 'css.exe'
default['dcrum']['css']['installer_remote']     = "#{node['dcrum']['common']['remote_loc']}/#{node['dcrum']['css']['file_name']}"
default['dcrum']['css']['installer']            = "#{node['dcrum']['common']['dynatrace_loc']}\\#{node['dcrum']['css']['file_name']}"
default['dcrum']['css']['db_name']              = 'TESTDB_CSS'

# RUM Attributes
default['dcrum']['rum']['installer_properties'] = "#{node['dcrum']['common']['dynatrace_loc']}\\RUM.properties"
default['dcrum']['rum']['install_dir']          = 'C:\\\\Program Files\\\\Dynatrace\\\\RUM Console'
default['dcrum']['rum']['key_dir']              = "#{node['dcrum']['rum']['install_dir']}\\cva"
default['dcrum']['rum']['file_name']            = 'console.exe'
default['dcrum']['rum']['installer_remote']     = "#{node['dcrum']['common']['remote_loc']}/#{node['dcrum']['rum']['file_name']}"
default['dcrum']['rum']['installer']            = "#{node['dcrum']['common']['dynatrace_loc']}\\#{node['dcrum']['rum']['file_name']}"
default['dcrum']['rum']['db_name']              = 'TESTDB_RUM'

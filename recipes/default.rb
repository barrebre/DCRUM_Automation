#
# Cookbook Name:: dcrum_automation
# Recipe:: default
#

# Creates the C:\Dynatrace folder
directory node['dcrum']['common']['dynatrace_loc'] do
  action :create
  not_if { ::File.directory?("#{node['dcrum']['common']['dynatrace_loc']}") }
end

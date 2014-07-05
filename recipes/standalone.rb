#
# Cookbook Name:: coldfusion11
# Recipe:: standalone
#
# Copyright 2012, NATHAN MISCHE
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

class Chef::Recipe
  include CF11Entmanager 
  include CF11Passwords
end

class Chef::Resource::RubyBlock
  include CF11Entmanager 
  include CF11Passwords
end

# Load password from encrypted data bag, data bag (:solo), or node attribute
pwds = get_passwords(node)

if !node['cf11']['installer']['installer_type'].match("standalone")
  Chef::Application.fatal!("ColdFusion 11 installer type must be 'standalone' for standalone installation!")
end

# Run the installer
include_recipe "coldfusion11::install"

# Link the init script
link "/etc/init.d/coldfusion" do
  to "#{node['cf11']['installer']['install_folder']}/cfusion/bin/coldfusion"
end
# file "/etc/init.d/coldfusion" do
#   owner 'root'
#   group 'root'
#   mode 0755
#   content ::File.open("#{node['cf11']['installer']['install_folder']}/cfusion/bin/coldfusion").read
#   action :create
# end

ruby_block "insert_line" do
  block do
    file = Chef::Util::FileEdit.new("#{node['cf11']['installer']['install_folder']}/cfusion/bin/coldfusion")
    file.search_file_replace(/CF_DIR=\$\(cd "\$\(dirname "\$0"\)"; pwd\).*$/, "CF_DIR=\"#{node['cf11']['installer']['install_folder']}/cfusion/\"")
    file.search_file_replace(/exit 2/, "exit 0")
    file.write_file
  end
end

# Set up ColdFusion as a service
coldfusion11_service "coldfusion" do
  instance "cfusion"
end

# Start ColdFusion immediatly so we can initilize it
execute "start_cf_for_coldfusion11_standalone" do
 command "/bin/true"
 notifies :start, "service[coldfusion]", :immediately
 only_if { File.exists?("#{node['cf11']['installer']['install_folder']}/cfusion/wwwroot/CFIDE/administrator/cfadmin.wzrd") }
end

# Initialize the instance
ruby_block "initialize_coldfusion" do
 block do
   # Initilize the instance
   init_instance("cfusion", pwds['admin_password'], node)
   # Update the node's instances_xml
   update_node_instances(node)
 end
 action :create
 only_if { File.exists?("#{node['cf11']['installer']['install_folder']}/cfusion/wwwroot/CFIDE/administrator/cfadmin.wzrd") }
end

# Link the jetty init script, if installed
link "/etc/init.d/cfjetty" do
  to "#{node['cf11']['installer']['install_folder']}/cfusion/jetty/cfjetty"
  only_if { File.exists?("#{node['cf11']['installer']['install_folder']}/cfusion/jetty/cfjetty") }
end

# Set up jetty as a service, if installed
service "cfjetty" do
  pattern "\\/bin\\/sh.*cfjetty start"
  status_command "ps -ef | grep '\\/bin\\/sh.*cfjetty start'" if platform_family?("rhel")
  supports :restart => true
  action [ :enable, :start ]
  only_if { File.exists?("#{node['cf11']['installer']['install_folder']}/cfusion/jetty/cfjetty") }
end

# Create the webroot if it doesn't exist
directory node['cf11']['webroot'] do
  owner node['cf11']['installer']['runtimeuser']
  mode "0755"
  action :create
  not_if { File.directory?(node['cf11']['webroot']) }
end


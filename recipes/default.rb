#
# Cookbook Name:: spip
# Recipe:: default
#
# Copyright (C) 2013 Rapid7
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# TODO: Create separate standalone and xampp recipes since SPIP uses Apache2,
# MySQL, and PHP

include_recipe 'apache2'
apache_site 'default' # REVIEW

include_recipe 'apache2::mod_php5'

include_recipe 'mysql::server'
include_recipe 'php' # REVIEW

package 'php5-mysql' # TODO: Determine if this is necessary

# TODO: Allow auxiliary paths
directory '/var/www' do
  owner 'root'
  group 'root'
  mode 0777
end

template '/var/www/spip_loader.php' do
  # NOTE: I haven't updated the langauge used in the loader script I even added
  #       a comment explaining the ERB I added in French for consistency. It'd
  #       be great if someone took the time to translate the code and code
  #       comments. For the mean time I've added it as spip_loader.fr.php.erb to
  #       denote the language as French.
  source 'spip_loader.fr.php.erb'
  variables :package_path => node[:spip][:package_path]
  mode 0644
end

=begin
# TODO: Determine if curling is possible or if we should switch to using the
# source code instead of a PHP script.
package 'curl'
execute 'run spip_loader.php script' do
  command 'curl http://127.0.0.1/spip_loader.php'
end

# NOTE: The http_request resource expects the data/response to be JSON
http_request "create/reset database" do
  action :get
  url 'http://127.0.0.1/spip_loader.php'
end
=end

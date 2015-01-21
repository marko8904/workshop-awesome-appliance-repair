#
# Cookbook Name:: AwesomeApplianceRepair
# Recipe:: default
#
# Copyright (C) 2015 Marko and Aislan
#
# All rights reserved - Do Not Redistribute
#
execute "apt-get-update-periodic" do
  command "apt-get update"
  ignore_failure true
  only_if do
    File.exists?('/var/lib/apt/periodic/update-success-stamp') &&
    File.mtime('/var/lib/apt/periodic/update-success-stamp') < Time.now - 86400
  end
end

package 'apache2'
package 'mysql-server'
package 'unzip'
package 'python'
package 'wget'

#execute "wget https://github.com/colincam/Awesome-Appliance-Repair/archive/master.zip"

#using remote_file is probably more stable
# remote_file "/tmp/master.zip" do
#    source "https://github.com/colincam/Awesome-Appliance-Repair/archive/master.zip"
#    action :create
# end

git "/tmp/Awesome-Appliance-Repair" do
   repository "https://github.com/colincam/Awesome-Appliance-Repair.git"
   revision "master"
end

execute "cp -RPpf AAR /var/www/" do
   cwd "/tmp/Awesome-Appliance-Repair"
   user "root"
end

execute "python AARinstall.py" do
   cwd "/tmp/Awesome-Appliance-Repair"
   user "root"
end
   

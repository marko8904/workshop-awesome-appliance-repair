#
# Cookbook Name:: AwesomeApplianceRepair
# Recipe:: default
#
# Copyright (C) 2015 Marko and Aislan
#
# All rights reserved - Do Not Redistribute
#

package 'apache2'
package 'mysql5'
package 'unzip'
package 'python'
package 'wget'

#execute "wget https://github.com/colincam/Awesome-Appliance-Repair/archive/master.zip"

#using remote_file is probably more stable
remote_file "/tmp/master.zip" do
   source "https://github.com/colincam/Awesome-Appliance-Repair/archive/master.zip"
   action :create
end

# git "aar" do
#    end
   

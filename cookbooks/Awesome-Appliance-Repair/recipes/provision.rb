require 'chef/provisioning/aws_driver'
with_driver 'aws'
 
name = "Awesome"
 
# declare security groups
aws_security_group "#{name}-ssh" do
  inbound_rules [{:ports => 22, :protocol => :tcp, :sources => ['0.0.0.0/0'] }]
end
 
aws_security_group "#{name}-http" do
  inbound_rules [{:ports => 80, :protocol => :tcp, :sources => ['0.0.0.0/0'] }]
end
 
# specify what's needed to create a machine
with_machine_options({
  :bootstrap_options => {
    :instance_type => "t1.micro",
    :key_name => "aws-popup-loft",
    :security_groups => [ "#{name}-ssh","#{name}-http"]
  },
  :ssh_username => "ubuntu",
  :image_id => "ami-98aa1cf0"
})

machine "#{name}-webserver-1" do
	recipe "Awesome-Appliance-Repair::default"
	tag "Awesome-Appliance-Repair"
	converge true
end
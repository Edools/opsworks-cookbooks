Chef::Log.info("Configuring Batman")

Chef::Log.info("Creating shell file to set npm variables")

template "/usr/local/bin/batman.sh" do
  source "batman.sh.erb"
  mode "0755"
  owner "root"
  group "root"
end

Chef::Log.info("Exporting batman variables for every new created process")
execute "/usr/local/bin/batman.sh" do
  user "root"
  action :run
end

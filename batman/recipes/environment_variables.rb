Chef::Log.info("Setting environment variables")

app = search("aws_opsworks_app").first
user = node[:deploy][:user]

# Chef::Log.info("Setting environment variables for current process")
# app[:environment].each do |name, value|
#   ENV["#{name}"] = "#{value}"
# end

Chef::Log.info("Writing variables to /etc/environment to have them after restart")
template "/etc/environment" do
  source "environment.erb"
  mode "0644"
  owner "root"
  group "root"
  variables({
    :environment_variables => app[:environment]
  })
end

Chef::Log.info("Creating shell file to export variables")
template "/usr/local/bin/environment.sh" do
  source "environment.sh.erb"
  mode "0755"
  owner "root"
  group "root"
  variables({
    :environment_variables => app[:environment]
  })
end

Chef::Log.info("[root] Exporting variables for every new created process")
execute "/usr/local/bin/environment.sh" do
  user "root"
  action :run
end

Chef::Log.info("[#{user}] Exporting variables for every new created process")
execute "/usr/local/bin/environment.sh" do
  user user
  action :run
end

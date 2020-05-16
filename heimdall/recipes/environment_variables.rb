app = search("aws_opsworks_app").first

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
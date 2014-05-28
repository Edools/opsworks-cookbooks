Chef::Log.info("Setting environment variables")

node[:deploy].each do |application, deploy|
  node[:environment_variables].each do |name, value|
    Chef::Log.info("Exporting: #{name}")
    ENV["#{name}"] = "#{value}"
  end

  Chef::Log.info("Creating shell file to export variables")
  template "/usr/local/bin/environment.sh" do
    source "environment.sh.erb"
    mode "0755"
      owner deploy[:user]
      group deploy[:group]
  end

  Chef::Log.info("Exporting variables")
  execute "/usr/local/bin/environment.sh" do
    action :run
  end
end

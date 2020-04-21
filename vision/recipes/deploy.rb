Chef::Log.info("[Start] Vision bot deploy")

app = search("aws_opsworks_app").first

Chef::Log.info("#{app[:app_source][:ssh_key]}")
Chef::Log.info("[Start] Vision bot deploy - URL")
Chef::Log.info("#{app[:app_source][:url]}")
Chef::Log.info("[Start] Vision bot deploy- VAR")
Chef::Log.info("#{app[:environment][:EXTERNAL_URL]}")
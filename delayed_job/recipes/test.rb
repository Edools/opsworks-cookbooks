Chef::Log.info("[Start] Testing recipe")

node[:deploy].each do |application, deploy_config|
  application_deploy = node[:deploy][application]
  Chef::Log.info("application_deploy path: #{application_deploy[:deploy_to]}")
  Chef::Log.info("deploy_config path: #{application_deploy[:deploy_to]}")
end

Chef::Log.info("[End] Tested recipe")

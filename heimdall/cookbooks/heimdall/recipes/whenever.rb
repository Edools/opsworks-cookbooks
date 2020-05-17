# Chef::Log.info("[Start] Updating Cron by Whenever")
# 
# app = search("aws_opsworks_app").first
# deploy_to = "#{node[:deploy][:to]}/#{app[:shortname]}"
# rails_env = app[:environment]['RAILS_ENV']
# 
# # node[:deploy].each do |application, deploy|
#   # deploy = node[:deploy][application]
# 
#   bash "update-crontab" do
#     # layers = node[:opsworks][:instance][:layers]
# 
#     cwd "#{deploy_to}/current"
#     user 'deploy'
# 
#     Chef::Log.info("Updating cron ...")
# 
#     code "bundle exec whenever --set environment=#{rails_env} --update-crontab #{app[:shortname]}"
#     only_if "cd #{deploy_to}/current && bundle show whenever"
#   end
# 
# # end
# 
# Chef::Log.info("[End] Updating Cron by Whenever")
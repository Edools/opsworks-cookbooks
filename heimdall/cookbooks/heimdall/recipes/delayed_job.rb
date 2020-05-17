Chef::Log.info("[Restart] Delayed Job ...")

app = search("aws_opsworks_app").first
deploy_to = "#{node[:deploy][:to]}/#{app[:shortname]}"

# node[:deploy].each do |application, deploy|
#   deploy = node[:deploy][application]

  bash "restart-delayed_job" do
    # layers = node[:opsworks][:instance][:layers]

    cwd "#{deploy_to}/current"
    user 'deploy'

    Chef::Log.info("Restarting delayed_job ...")

    code <<-EOH
      rm -f start.sh
      echo "#! /bin/sh" >> start.sh
      echo "RAILS_ENV=production bundle exec rake jobs:work" >> start.sh
      kill -9 $(ps aux | grep jobs:work | grep -v grep | awk '{print $2}')
      chmod +x start.sh
      nohup ./start.sh 0<&- &> my.admin.log.file &
    EOH
  end
  
# end

Chef::Log.info("[End] Restarting Delayed Job")

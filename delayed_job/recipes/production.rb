Chef::Log.info("[Restart] Delayed Job ...")

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  bash "restart-delayed_job-#{application}" do
    layers = node[:opsworks][:instance][:layers]

    cwd "/srv/www/core/current"
    user 'deploy'

    Chef::Log.info("Restarting delayed_job ...")

    code <<-EOH
      rm -f start.sh
      echo "#! /bin/sh" >> start.sh
      echo "RAILS_ENV=production bin/delayed_job --pool=payment --pool=hermes:2 --pool=default --pool=report start" >> start.sh
      kill -9 $(ps aux | grep delayed_job | grep -v grep | awk '{print $2}')
      chmod +x start.sh
      nohup ./start.sh 0<&- &> my.admin.log.file &
    EOH
  end
end

Chef::Log.info("[End] Restarting Delayed Job")

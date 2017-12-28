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
      echo "RAILS_ENV=production bin/delayed_job -i payment --queue=payment start" >> start.sh
      echo "RAILS_ENV=production bin/delayed_job -i hermes --queue=hermes start" >> start.sh
      echo "RAILS_ENV=production bin/delayed_job -i default --queue=default start" >> start.sh
      echo "RAILS_ENV=production bin/delayed_job -i report --queue=report start" >> start.sh
      echo "RAILS_ENV=production bin/delayed_job -i lesson_progress --queue=lesson_progress start" >> start.sh
      echo "RAILS_ENV=production bin/delayed_job -i bulk_invitation --queue=bulk_invitation start" >> start.sh
      kill -9 $(ps aux | grep delayed_job | grep -v grep | awk '{print $2}')
      chmod +x start.sh
      nohup ./start.sh 0<&- &> my.admin.log.file &
    EOH
  end
end

Chef::Log.info("[End] Restarting Delayed Job")

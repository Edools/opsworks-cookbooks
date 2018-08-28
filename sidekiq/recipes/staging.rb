Chef::Log.info("[Restart] SideKiq...")

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  bash "restart-sidekiq-#{application}" do
    layers = node[:opsworks][:instance][:layers]

    cwd "/srv/www/core/current"
    user 'deploy'

    Chef::Log.info("Restarting sidekiq ...")

    code <<-EOH
      rm -f start_sidekiq.sh
      echo "#! /bin/sh" >> start_sidekiq.sh
      echo "bundle exec sidekiq -d -L log/sidekiq.log -C config/sidekiq.yml -e staging -q searchkick" >> start_sidekiq.sh
      echo "bundle exec sidekiq -d -L log/sidekiq.log -C config/sidekiq.yml -e staging -q hermes" >> start_sidekiq.sh
      kill -9 $(ps aux | grep sidekiq | grep -v grep | awk '{print $2}')
      chmod +x start_sidekiq.sh
      nohup ./start_sidekiq.sh 0<&- &> log/sidekiq_start.log &
    EOH
  end
end

Chef::Log.info("[End] Restarting SideKiq")

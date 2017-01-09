Chef::Log.info("[Restart] Delayed Job ...")

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  bash "restart-delayed_job-#{application}" do
    layers = node[:opsworks][:instance][:layers]

    cwd "#{deploy[:deploy_to]}/current"
    user 'deploy'

    Chef::Log.info("Restarting delayed_job ...")

    code <<-EOH
      touch start.sh
    EOH
    
    file 'start.sh' do
      content '
        #! /bin/sh
        RAILS_ENV=production bundle exec rake jobs:work
      '
    end

    code <<-EOH
      kill -9 $(ps aux | grep jobs:work | grep -v grep | awk '{print $2}')
      chmod +x start.sh
      nohup ./start.sh 0<&- &> my.admin.log.file &
    EOH
  end
end

Chef::Log.info("[End] Restarting Delayed Job")

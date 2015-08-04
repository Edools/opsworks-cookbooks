Chef::Log.info("[Restart] Delayed Job ...")

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  bash "restart-delayed_job-#{application}" do
    layers = node[:opsworks][:instance][:layers]

    cwd "#{deploy[:deploy_to]}/current"
    user 'deploy'

    Chef::Log.info("Restarting delayed_job ...")

    code <<-EOH
      RAILS_ENV=#{deploy[:rails_env]} bin/delayed_job stop
      RAILS_ENV=#{deploy[:rails_env]} bin/delayed_job start
      EOH
  end
end

Chef::Log.info("[End] Restarting Delayed Job")

Chef::Log.info("[Stop] Delayed Job ...")

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  bash "stop-delayed_job-#{application}" do
    layers = node[:opsworks][:instance][:layers]

    cwd "#{deploy[:deploy_to]}/current"
    user 'deploy'

    Chef::Log.info("Restarting delayed_job ...")

    code <<-EOH
      RAILS_ENV=#{deploy[:rails_env]} bin/delayed_job stop
      EOH
  end
end

Chef::Log.info("[End]Delayed Job Stoped")

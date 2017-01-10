Chef::Log.info("[Stop] Delayed Job Rake...")

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  bash "restart-delayed_job-#{application}" do
    layers = node[:opsworks][:instance][:layers]

    cwd "#{deploy[:deploy_to]}/current"
    user 'deploy'
    code <<-EOH
      kill -9 $(ps aux | grep jobs:work | grep -v grep | awk '{print $2}')
    EOH
  end
end

Chef::Log.info("[Stop] Stoping Delayed Job")

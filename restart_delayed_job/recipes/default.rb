Chef::Log.info("Restarting Delayed Job")

node[:deploy].each do |application, deploy|
  execute "Restarting Delayed Job" do
    command "RAILS_ENV=production #{deploy[:deploy_to]}/current/bin/delayed_job restart"
  end
end

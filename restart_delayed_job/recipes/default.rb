Chef::Log.info("Restarting Delayed Job")

node[:deploy].each do |application, deploy|
  execute "Restarting Delayed Job" do
    command "sudo su -c 'RAILS_ENV=production #{deploy[:deploy_to]}/current/bin/delayed_job restart' #{deploy[:user]}"
  end
end

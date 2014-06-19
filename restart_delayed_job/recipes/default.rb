Chef::Log.info("Restarting Delayed Job")

node[:deploy].each do |application, deploy|
  execute "Restarting Delayed Job" do
    command "sudo su #{deploy[:user]}"
    command "cd #{deploy[:deploy_to]}/current"
    command "RAILS_ENV=production #{deploy[:deploy_to]}/current/bin/delayed_job restart"
    command "exit"
    # command "sudo su #{deploy[:user]} -c 'RAILS_ENV=production #{deploy[:deploy_to]}/current/bin/delayed_job restart'"
  end

end

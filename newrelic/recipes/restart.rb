Chef::Log.info("[Start] Restart newrelic")

execute "stop newrelic" do
	command('sudo initctl stop newrelic-infra')
end

execute "start newrelic" do
	command('sudo initctl start newrelic-infra')
end

Chef::Log.info("[End] Restart newrelic")
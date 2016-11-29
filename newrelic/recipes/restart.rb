Chef::Log.info("[Start] Restart newrelic")

execute "stop newrelic" do
	only_if('sudo initctl status newrelic-infra | grep running -c')

	command('sudo initctl stop newrelic-infra')
end

execute "start newrelic" do
	not_if('sudo initctl status newrelic-infra | grep running -c')

	command('sudo initctl start newrelic-infra')
end

Chef::Log.info("[End] Restart newrelic")
Chef::Log.info("[Start] Restart newrelic")

execute "stop newrelic" do
	only_if('sudo initctl status newrelic-infra | grep running')
	Chef::Log.info("TEST STOP NEWRELIC #1")
	only_if('sudo initctl status newrelic-infra | grep running -c')
	Chef::Log.info("TEST STOP NEWRELIC #2")
	command('sudo initctl stop newrelic-infra')
end

execute "start newrelic" do
	not_if('sudo initctl status newrelic-infra | grep running')
	Chef::Log.info("TEST START NEWRELIC #1")
	not_if('sudo initctl status newrelic-infra | grep running -c')
	Chef::Log.info("TEST START NEWRELIC #2")
	command('sudo initctl start newrelic-infra')
end

Chef::Log.info("[End] Restart newrelic")
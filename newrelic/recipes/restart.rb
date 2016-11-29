Chef::Log.info("[Start] Restart newrelic")

execute "create a configuration file with license key" do
	command('printf "license_key: 62ba8700373589b340a692b6acad3432c1bb695a" | sudo tee /etc/newrelic-infra.yml')
end

execute "stop newrelic" do
	only_if('sudo initctl status newrelic-infra | grep running -c')
	
	command('sudo initctl stop newrelic-infra')
end

execute "start newrelic" do
	not_if('sudo initctl status newrelic-infra | grep running -c')

	command('sudo initctl start newrelic-infra')
end

Chef::Log.info("[End] Restart newrelic")
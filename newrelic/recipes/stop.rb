Chef::Log.info("[Start] Stop newrelic")

execute "stop newrelic" do
	only_if('sudo initctl status newrelic-infra | grep running')
	command('sudo initctl stop newrelic-infra')
end

Chef::Log.info("[End] Stop newrelic")
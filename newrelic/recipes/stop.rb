Chef::Log.info("[Start] Stop newrelic")

execute "stop newrelic" do
	command('sudo initctl stop newrelic-infra')
end

Chef::Log.info("[End] Stop newrelic")
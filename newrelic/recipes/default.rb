Chef::Log.info("[Start] Installing newrelic")

execute "create a configuration file with license key" do
	command('printf "license_key: 62ba8700373589b340a692b6acad3432c1bb695a" | sudo tee -a /etc/newrelic-infra.yml')
end

execute "enable gpg key" do
	command('curl https://download.newrelic.com/infrastructure_agent/gpg/newrelic-infra.gpg | sudo apt-key add -')
end

execute "create the agents apt repo" do
	command('printf "deb [arch=amd64] http://download.newrelic.com/infrastructure_agent/linux/apt trusty main" | sudo tee -a /etc/apt/sources.list.d/newrelic-infra.list')
end

execute "update apt cache" do
	command('sudo apt-get update')
end

execute "install newrelic" do
	command('sudo apt-get install newrelic-infra -y')
end

Chef::Log.info("[End] Installing newrelic")
Chef::Log.info("[Start] Installing newrelic")

execute "install newrelic" do
	command('printf "license_key: 62ba8700373589b340a692b6acad3432c1bb695a" | sudo tee -a /etc/newrelic-infra.yml')
	command('curl https://download.newrelic.com/infrastructure_agent/gpg/newrelic-infra.gpg | sudo apt-key add -')
	command('printf "deb http://download.newrelic.com/infrastructure_agent/linux/apt trusty main" | sudo tee -a /etc/apt/sources.list.d/newrelic-infra.list')
	command('sudo apt-get update')
	command('sudo apt-get install newrelic-infra -y')
end

Chef::Log.info("[End] Installing newrelic")
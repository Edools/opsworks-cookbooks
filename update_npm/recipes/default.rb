Chef::Log.info("Updating NPM")

execute "Update NPM" do
  command "npm install -g npm@1.4.23"
end

Chef::Log.info("NPM Updated")

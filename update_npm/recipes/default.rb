Chef::Log.info("Updating NPM")

execute "Update NPM" do
  command "npm install -g npm@1.4.9"
end

Chef::Log.info("Updating NPM")

execute "Update NPM" do
  command "npm install -g npm"
end

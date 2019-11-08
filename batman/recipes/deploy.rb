Chef::Log.info("[Start] Deploy batman production")

# http_request 'deploy production batman rollbar' do
#   
# end

directory "/batman" do
  mode 0755
  owner 'root'
  group 'root'
  action :create
end

execute 'enter batman folder' do
  cwd deploy[:current_path]
end

execute 'install project' do
  command 'npm install && npm run build'
end

execute 'run migrations' do
  command 'npm run sequelize:migrate'
end

execute 'start app' do
  command 'export NODE_ENV=production'
  command 'pm2 reload ecosystem.config.js --env production'
end

Chef::Log.info("[End] Deploy batman production")
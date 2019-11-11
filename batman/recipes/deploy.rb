Chef::Log.info("[Start] Deploy batman production ")

# http_request 'deploy production batman rollbar' do
#   
# end

bash 'install project' do
  code 'npm install && npm run build'
end

bash 'run migrations' do
  code 'npm run sequelize:migrate'
end

bash 'start app' do
  code 'export NODE_ENV=production'
  code 'pm2 reload ecosystem.config.js --env production'
end

Chef::Log.info("[End] Deploy batman production")
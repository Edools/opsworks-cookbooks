Chef::Log.info("[Start] Deploy batman production")

# http_request 'deploy staging batman circle' do
#   url "https://circleci.com/api/v1.1/project/gitlab/herospark/batman/tree/master?circle-token=f22ba03ebad89e84d1b56297557bb8bb499f9d28"
#   action :post
# end

execute 'enter batman folder' do
  cwd 'batman'
end

execute 'enter batman folder' do
  command 'npm install'
end

execute 'run migrations' do
  command 'npm run sequelize:migrate'
end

execute 'start app' do
  command 'pm2 start npm -- start NODE_ENV=production'
end

Chef::Log.info("[End] Deploy batman production")
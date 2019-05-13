Chef::Log.info("[Start] Deploy batman production")

http_request 'deploy staging batman circle' do
  url "https://circleci.com/api/v1.1/project/gitlab/herospark/batman/tree/master?circle-token=f22ba03ebad89e84d1b56297557bb8bb499f9d28"
  action :post
end

execute 'enter batman folder' do
  command 'cd batman'
end

execute 'enter batman folder' do
  command 'npm install'
end

file './.env' do
  content '
    DATABASE_URL=postgres://batmanprod:CNiKN4kx3Enr#5#MpC@herospark-batman-prod.cgw16rftvhop.us-east-1.rds.amazonaws.com:5432/herosparkbatman
    SECRET_KEY=SCGrmUrT7Or3fn01cWWx4an7QpW6eKCC
    PORT=3000
    REDIS_URL=redis://KBCFOJDZHBGDOKZQ@aws-us-east-1-portal.33.dblayer.com:18578
    URL=http://localhost:3000
  '
end

execute 'run migrations' do
  command 'npm run sequelize:create-migration" && npm run sequelize:migrate'
end

execute 'start app' do
  command 'pm2 start npm -- start NODE_ENV=production'
end

Chef::Log.info("[End] Deploy batman production")
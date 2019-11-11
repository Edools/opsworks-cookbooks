Chef::Log.info("[Start] Deploy batman production ")

# http_request 'deploy production batman rollbar' do
#   
# end

execute "update-upgrade" do
  command "sudo apt-get update -y
          sudo apt-get install nodejs -y
          sudo apt-get install npm -y
          sudo apt-get install python -y
          sudo npm install n --global
          sudo n 10.15.3
          sudo npm install node-gyp --global
          sudo npm install pm2 --global
          sudo apt-get install libcap2-bin
          sudo setcap cap_net_bind_service=+ep `readlink -f \`which node\``"
  action :run
end

execute 'install project' do
  command 'npm run build'
  action :run
end

execute 'run migrations' do
  command 'npm run sequelize:migrate'
  action :run
end

bash 'start app' do
  code 'export NODE_ENV=production'
  code 'pm2 reload ecosystem.config.js --env production'
end

Chef::Log.info("[End] Deploy batman production")
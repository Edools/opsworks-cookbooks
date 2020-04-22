Chef::Log.info("[Start] Setup PM2")

setup_sh_file = '/setup_pm2.sh'
user = node[:deploy][:user]

file setup_sh_file do
  content '
    # setup.sh
    #! /bin/bash
    sudo apt-get --yes --force-yes install npm
    sudo npm install -g pm2
  '
end

bash 'setup ngnix' do
  code 'source /setup_pm2.sh'
  # user user
end

Chef::Log.info("[End] Setup PM2")
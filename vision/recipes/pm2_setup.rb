Chef::Log.info("[Start] Setup PM2")

setup_sh_file = '/setup_pm2.sh'
user = node[:deploy][:user]

file setup_sh_file do
  content '
    # setup.sh
    #! /bin/bash
    sudo apt-get --yes --force-yes install npm
    sudo npm install -g pm2
    sudo env PATH=$PATH:/usr/bin /usr/local/lib/node_modules/pm2/bin/pm2 startup systemd -u ubuntu --hp /home/ubuntu
  '
end

bash 'setup ngnix' do
  code 'source /setup_pm2.sh'
end

Chef::Log.info("[End] Setup PM2")
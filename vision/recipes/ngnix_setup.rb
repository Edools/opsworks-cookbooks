Chef::Log.info("[Start] Setup Ngnix")

setup_sh_file = '/setup_ngnix.sh'

file setup_sh_file do
  content '
    # setup.sh
    #! /bin/bash
    sudo apt update
    sudo apt install nginx
    sudo mkdir /tmp/nginx_cache
    
    sudo apt-get install software-properties-common
    sudo add-apt-repository ppa:certbot/certbot
    sudo apt-get update
    sudo apt-get install python-certbot-nginx
    sudo certbot --nginx
  '
end

bash 'setup ngnix' do
  code 'source /setup_ngnix.sh'
end

Chef::Log.info("[End] Setup Ngnix")
Chef::Log.info("[Start] Setup Ngnix")

setup_sh_file = '/setup_ngnix.sh'

file setup_sh_file do
  content '
    # setup.sh
    #! /bin/bash
    sudo apt-get -y update
    sudo apt-get --yes --force-yes install nginx
    sudo mkdir /tmp/nginx_cache
  '
end

bash 'setup ngnix' do
  code 'source /setup_ngnix.sh'
end

Chef::Log.info("[End] Setup Ngnix")
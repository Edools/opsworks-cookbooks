Chef::Log.info("[Start] Setup NodeJS")

setup_sh_file = '/setup_nodejs.sh'

file setup_sh_file do
  content '
    # setup.sh
    #! /bin/bash
    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    sudo apt-get -y update
    sudo apt-get install -y nodejs
  '
end

bash 'setup nodejs' do
  code 'source /setup_nodejs.sh'
end

Chef::Log.info("[End] Setup NodeJS")
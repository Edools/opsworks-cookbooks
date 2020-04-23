Chef::Log.info("[Start] Setup batman")

setup_sh_file = '/setup.sh'

file setup_sh_file do
  content '
    # setup.sh
    #! /bin/bash
    sudo apt-get update -y 
    sudo apt-get install nodejs -y
    sudo apt-get install npm -y
    sudo apt-get install python -y
    sudo npm install n --global
    sudo n 10.15.3
    sudo npm install node-gyp --global
    sudo npm install pm2 --global
    sudo apt-get install libcap2-bin
    sudo setcap cap_net_bind_service=+ep `readlink -f \`which node\``
  '
end

bash 'install batman dependencies' do
  code 'source /setup.sh'
end

Chef::Log.info("[End] Setup batman")
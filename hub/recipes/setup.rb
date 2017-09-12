Chef::Log.info("[Start] Setup hub")

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
    sudo n 5.6.0
    sudo npm install node-gyp --global
    sudo npm install pm2 --global
    sudo apt-get install libcap2-bin
    sudo setcap cap_net_bind_service=+ep `readlink -f \`which node\``
  '
end

bash 'install hub dependencies' do
  code 'source /setup.sh'
end

Chef::Log.info("[End] Setup hub")
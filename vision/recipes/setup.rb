Chef::Log.info("[Start] Setup Botpress")

setup_sh_file = '/setup.sh'

file setup_sh_file do
  content '
    # setup.sh
    #! /bin/bash
    sudo apt update
    sudo apt install unzip
    wget https://s3.amazonaws.com/botpress-binaries/botpress-v12_8_2-linux-x64.zip
    unzip botpress-v12_8_2-linux-x64.zip
    
    # Launch the app
    ./bp
  '
end

bash 'setup botpress' do
  code 'source /setup.sh'
end

Chef::Log.info("[End] Start BotPress ")
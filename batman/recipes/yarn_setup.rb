Chef::Log.info("[Start] Setup Yarn")

setup_sh_file = '/setup_yarn.sh'

file setup_sh_file do
  content '
    # setup.sh
    #! /bin/bash
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update && sudo apt install yarn
  '
end

bash 'setup yarn' do
  code 'source /setup_yarn.sh'
end

Chef::Log.info("[End] Setup Ngnix")
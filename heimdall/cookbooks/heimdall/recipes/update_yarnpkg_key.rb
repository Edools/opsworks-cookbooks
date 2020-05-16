Chef::Log.info("[Start] Update Yarn Key")

setup_sh_file = '/setup_update_yarn_key.sh'

file setup_sh_file do
  content '
    # setup.sh
    #! /bin/bash
    wget -O yarnpkg.gpg.pub https://dl.yarnpkg.com/debian/pubkey.gpg
    gpg yarnpkg.gpg.pub
    sudo apt-key add yarnpkg.gpg.pub
  '
end

bash 'setup yarn' do
  code 'source /setup_update_yarn_key.sh'
end

Chef::Log.info("[End] Update Yarn Key")
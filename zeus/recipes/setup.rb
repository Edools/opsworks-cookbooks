Chef::Log.info("[Start] Setup zeus")

bash "install zues dependencies" do
  code <<-EOH
    sudo apt-get update -y 
    sudo apt-get install nodejs -y
    sudo apt-get install npm -y
    sudo apt-get install python -y
    sudo npm install n --global
    sudo n 5.6.0
    sudo npm install node-gyp --global
    sudo npm install pm2 --global
    sudo apt-get install libcap2-bin 
  EOH
end

Chef::Log.info("[End] Setup zeus")
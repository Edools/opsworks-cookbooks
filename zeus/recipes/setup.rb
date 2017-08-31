Chef::Log.info("[Start] Setup zeus")

execute "install zeus dependencies" do
  command("sudo apt-get update -y ")
  command("sudo apt-get install nodejs -y")
  command("sudo apt-get install npm -y")
  command("sudo apt-get install python -y")
  command("sudo npm install n --global")
  command("sudo n 5.6.0")
  command("sudo npm install node-gyp --global")
  command("sudo npm install pm2 --global")
  command("sudo apt-get install libcap2-bin")
  command("sudo setcap cap_net_bind_service=+ep `readlink -f \\`which node\\``")
end

Chef::Log.info("[End] Setup zeus")

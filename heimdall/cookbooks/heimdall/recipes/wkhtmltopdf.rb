Chef::Log.info('Starting wkhtmltopdf check/install')

execute "downloading wkhtmltopdf" do
  command "wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb"
end

execute "install wkhtmltopdf" do
  command "sudo apt-get install -y ./wkhtmltox_0.12.5-1.bionic_amd64.deb"
end

execute "coping wkhtmltopdf" do
  command "sudo cp /usr/local/bin/wkhtmltopdf /usr/bin/wkhtmltopdf"
end

Chef::Log.info('Finishing wkhtmltopdf check/install')

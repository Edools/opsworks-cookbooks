Chef::Log.info('Starting wkhtmltopdf check/install')

execute "downloading wkhtmltopdf" do
  command "wget https://s3.amazonaws.com/clientes-edools-3/wkhtmltox-0.12.2_linux-trusty-amd64.deb"
end

execute "install wkhtmltopdf" do
  command "sudo dpkg -i wkhtmltox-0.12.2_linux-trusty-amd64.deb"
end

execute "coping wkhtmltopdf" do
  command "sudo cp /usr/local/bin/wkhtmltopdf /usr/bin/wkhtmltopdf"
end

Chef::Log.info('Finishing wkhtmltopdf check/install')

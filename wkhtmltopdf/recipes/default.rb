Chef::Log.info('Starting wkhtmltopdf check/install')

execute "install wkhtmltopdf" do
  command "wget http://download.gna.org/wkhtmltopdf/0.12/0.12.2/wkhtmltox-0.12.2_linux-trusty-amd64.deb"
  command "sudo dpkg -i wkhtmltox-0.12.2_linux-trusty-amd64.deb"
  command "sudo cp /usr/local/bin/wkhtmltopdf /usr/bin/wkhtmltopdf"
end

Chef::Log.info('Finishing wkhtmltopdf check/install')
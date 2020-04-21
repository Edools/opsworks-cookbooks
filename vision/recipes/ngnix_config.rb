Chef::Log.info("[Start] Config nginx")

nginx_conf_file = '/etc/nginx/nginx.conf'

execute "move nginx configuration file to tmp" do
  command("mv #{nginx_conf_file} /etc/nginx/nginx.conf.tmp")
  
  only_if do
    ::File.exists?("#{nginx_conf_file}")
  end
end

Chef::Log.info("Creating Ngnix config file")
template "/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
  mode "0644"
  owner "root"
  group "root"
end

execute "restart nginx" do
  command('sudo service nginx restart')
end

Chef::Log.info("[End] Config nginx")

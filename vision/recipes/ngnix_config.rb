Chef::Log.info("[Start] Config nginx")

nginx_conf_file = '/etc/nginx/nginx.conf'

execute "move nginx configuration file to tmp" do
  command("mv #{nginx_conf_file} /etc/nginx/nginx.conf.tmp")
  
  only_if do
    ::File.exists?("#{nginx_conf_file}")
  end
end

# file nginx_conf_file do
#   content '	user www-data;
#             worker_processes  2;
#             pid        /run/nginx.pid;
# 
#             events {
#               worker_connections  65536;
#               multi_accept        on;
#               use                 epoll;
#             }
# 
#             http {
#               include       /etc/nginx/mime.types;
#               default_type  application/octet-stream;
# 
#               # Disable sending the server identification
#               server_tokens off;
# 
#               # Prevent displaying Botpress in an iframe (clickjacking protection)
#               add_header X-Frame-Options SAMEORIGIN;
# 
#               # Prevent browsers from detecting the mimetype if not sent by the server.
#               add_header X-Content-Type-Options nosniff;
# 
#               # Force enable the XSS filter for the website, in case it was disabled manually
#               add_header X-XSS-Protection "1; mode=block";
# 
#               # Configure the cache for static assets
#               proxy_cache_path /srv/nginx_cache levels=1:2 keys_zone=my_cache:10m max_size=10g inactive=60m use_temp_path=off;
# 
#               # Set the max file size for uploads (make sure it is larger than the configured media size in botpress.config.json)
#               client_max_body_size 10M;              
# 
#               access_log	/var/log/nginx/access.log;
#               access_log off;
#               error_log  /var/log/nginx/error.log;
# 
#               # Redirect requests to the server
#               server {
#                 listen 80 default;
#                 server_name  localhost;
# 
#                 # All other requests should be directed to the server
#                 location / {
#                   proxy_pass http://localhost:3000;
#                 }
#               }
# 
#               # include /etc/nginx/conf.d/*.conf;
#               # include /etc/nginx/sites-enabled/*;
#             }'
# end

Chef::Log.info("Creating Ngnix config file")
template "/etc/nginx/nginx.conf" do
  source "ngnix.conf.erb"
  mode "0755"
  owner "root"
  group "root"
end

execute "restart nginx" do
  command('sudo service nginx restart')
end

Chef::Log.info("[End] Config nginx")

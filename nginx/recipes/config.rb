Chef::Log.info("[Start] Config nginx")

nginx_conf_file = '/etc/nginx/nginx.conf'

execute "move nginx configuration file to tmp" do
	command("mv #{nginx_conf_file} /etc/nginx/nginx.conf.tmp")
end

file nginx_conf_file do
  content '	user www-data;
						worker_processes  2;

						error_log  /var/log/nginx/error.log;
						pid        /run/nginx.pid;

						events {
						  worker_connections  65536;
						  multi_accept        on;
						  use                 epoll;
						}

						http {
						  include       /etc/nginx/mime.types;
						  default_type  application/octet-stream;


						  access_log	/var/log/nginx/access.log;
						  access_log off;

						  sendfile on;
						  tcp_nopush on;
						  tcp_nodelay on;

						  keepalive_timeout  65;
						  keepalive_requests 100000;

						  gzip  on;
						  gzip_static  on;
						  gzip_http_version 1.0;
						  gzip_comp_level 2;
						  gzip_proxied any;
						  gzip_types application/x-javascript application/xhtml+xml application/xml application/xml+rss text/css text/javascript text/plain text/xml;
						  gzip_vary on;
						  gzip_disable "MSIE [1-6].(?!.*SV1)";

						  client_body_buffer_size 10K;
						  client_header_buffer_size 1k;
						  client_max_body_size 8m;
						  large_client_header_buffers 2 1k;

						  server_names_hash_bucket_size 64;

						  include /etc/nginx/conf.d/*.conf;
						  include /etc/nginx/sites-enabled/*;
						}'
end

execute "restart nginx" do
	command('sudo service nginx restart')
end

Chef::Log.info("[End] Config nginx")
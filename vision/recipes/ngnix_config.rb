Chef::Log.info("[Start] Config nginx")

nginx_conf_file = '/etc/nginx/nginx.conf'

execute "move nginx configuration file to tmp" do
  command("mv #{nginx_conf_file} /etc/nginx/nginx.conf.tmp")
end

file nginx_conf_file do
  content '	user www-data;
            worker_processes  2;
            pid        /run/nginx.pid;

            events {
              worker_connections  65536;
              multi_accept        on;
              use                 epoll;
            }

            http {
              include       /etc/nginx/mime.types;
              default_type  application/octet-stream;
              
              # Disable sending the server identification
              server_tokens off
              
              # Prevent displaying Botpress in an iframe (clickjacking protection)
              add_header X-Frame-Options SAMEORIGIN;
              
              # Prevent browsers from detecting the mimetype if not sent by the server.
              add_header X-Content-Type-Options nosniff;
              
              # Force enable the XSS filter for the website, in case it was disabled manually
              add_header X-XSS-Protection "1; mode=block";
              
              # Configure the cache for static assets
              proxy_cache_path /sr/nginx_cache levels=1:2 keys_zone=my_cache:10m max_size=10g inactive=60m use_temp_path=off;
              
              # Set the max file size for uploads (make sure it is larger than the configured media size in botpress.config.json)
              client_max_body_size 10M;
              
              # Configure access
              log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                    '$status $body_bytes_sent "$http_referer" '
                    '"$http_user_agent" "$http_x_forwarded_for"';


              access_log	/var/log/nginx/access.log;
              access_log off;
              error_log  /var/log/nginx/error.log;
              
              # Redirect unsecure requests to the HTTPS endpoint
              server {
                listen 80 default;
                server_name  localhost;

                return 301 https://$server_name$request_uri;
              }
              
              server {
                listen 443 http2 ssl;
                server_name localhost;

                ssl_certificate      cert.pem;
                ssl_certificate_key  cert.key;

                # Force the use of secure protocols only
                ssl_prefer_server_ciphers on;
                ssl_protocols TLSv1 TLSv1.1 TLSv1.2;

                # Enable session cache for added performances
                ssl_session_cache shared:SSL:50m;
                ssl_session_timeout 1d;
                ssl_session_tickets off;

                # Added security with HSTS
                add_header Strict-Transport-Security "max-age=31536000; includeSubdomains; preload";

                # Enable caching of assets by NGINX to reduce load on the server
                location ~ .*/assets/.* {
                  proxy_cache my_cache;
                  proxy_ignore_headers Cache-Control;
                  proxy_hide_header Cache-Control;
                  proxy_hide_header Pragma;
                  proxy_pass http://localhost:3000;
                  proxy_cache_valid any 30m;
                  proxy_set_header Cache-Control max-age=30;
                  add_header Cache-Control max-age=30;
                }

                # We need to add specific headers so the websockets can be set up through the reverse proxy
                location /socket.io/ {
                  proxy_pass http://localhost:3000/socket.io/;
                  proxy_http_version 1.1;
                  proxy_set_header Upgrade $http_upgrade;
                  proxy_set_header Connection "Upgrade";
                }

                # All other requests should be directed to the server
                location / {
                  proxy_pass http://localhost:3000;
                }
              }

              # include /etc/nginx/conf.d/*.conf;
              # include /etc/nginx/sites-enabled/*;
            }'
end

execute "restart nginx" do
  command('sudo service nginx restart')
end

Chef::Log.info("[End] Config nginx")

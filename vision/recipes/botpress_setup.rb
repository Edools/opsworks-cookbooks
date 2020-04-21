Chef::Log.info("[Start] Setup Botpress")

# setup_sh_file = '/setup_botpress.sh'
# 
# file setup_sh_file do
#   content '
#     # setup.sh
#     #! /bin/bash
#     sudo apt-get install --yes --force-yes unzip
# 
# 
#     wget https://s3.amazonaws.com/botpress-binaries/botpress-v12_8_2-linux-x64.zip
#     unzip botpress-v12_8_2-linux-x64.zip
# 
#     # Launch the app
#     ./bp
#   '
# end
# 
# bash 'setup botpress' do
#   code 'source /setup.sh'
# end

execute "create botpress source dir" do
  command "mkdir #{node[:botpress][:source_dir]}"
  
  not_if do
    ::File.directory?("#{node[:botpress][:source_dir]}")
  end
end

execute "create botpress source dir to #{node[:botpress][:version]} version" do
  command "mkdir #{node[:botpress][:source_dir]}/#{node[:botpress][:version]}"
  
  not_if do
    ::File.directory?("#{node[:botpress][:source_dir]}/#{node[:botpress][:version]}")
  end
end

execute "download botpress binary to #{node[:botpress][:version]} version" do
  command "wget https://s3.amazonaws.com/botpress-binaries/botpress-#{node[:botpress][:version]}-#{node[:botpress][:platform]}.zip"
  cwd "#{node[:botpress][:source_dir]}/#{node[:botpress][:version]}"
  
  not_if do
    ::File.exists?("#{node[:botpress][:source_dir]}/#{node[:botpress][:version]}/botpress-#{node[:botpress][:version]}-#{node[:botpress][:platform]}.zip")
  end
end


Chef::Log.info("[End] Start BotPress ")
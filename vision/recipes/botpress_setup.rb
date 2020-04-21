Chef::Log.info("[Start] Setup Botpress")

botpress_file_name = "botpress-#{node[:botpress][:version]}-#{node[:botpress][:platform]}.zip"
botpress_url = "https://s3.amazonaws.com/botpress-binaries/#{botpress_file_name}"

botpress_base_dir = "#{node[:botpress][:source_dir]}"
botpress_current_dir = "#{node[:botpress][:source_dir]}/#{node[:botpress][:version]}"


execute "install unzip" do
  command "sudo apt-get install --yes --force-yes unzip"
end

execute "create botpress source dir" do
  command "mkdir #{botpress_base_dir}"
  
  not_if do
    ::File.directory?("#{botpress_base_dir}")
  end
end

execute "create botpress source dir to #{node[:botpress][:version]} version" do
  command "mkdir #{botpress_current_dir}"
  
  not_if do
    ::File.directory?("#{botpress_current_dir}")
  end
end

execute "download botpress binary to #{node[:botpress][:version]} version" do
  command "wget #{botpress_url}"
  cwd "#{botpress_current_dir}"
  
  not_if do
    ::File.exists?("#{botpress_current_dir}/#{botpress_file_name}")
  end
end

execute "unzip #{botpress_file_name}" do
  command "unzip #{botpress_file_name}"
  cwd "#{botpress_current_dir}"
  
  not_if do
    ::File.exists?("#{botpress_current_dir}/bp")
  end
end

execute "remove zip file #{botpress_file_name}" do
  command "rm -rf #{botpress_file_name}"
  cwd "#{botpress_current_dir}"
  
  only_if do
    ::File.exists?("#{botpress_current_dir}/#{botpress_file_name}")
  end
end


Chef::Log.info("[End] Start BotPress ")
Chef::Log.info("[Start] Configure Git")

app = search("aws_opsworks_app").first

user_dir = node[:deploy][:user_dir]
group = node[:deploy][:group]
user = node[:deploy][:user]

# create folder and file to SSH key
directory "#{user_dir}/.ssh" do
  owner user
  group group
  mode "0700"
  action :create
  recursive true
end

file "#{user_dir}/.ssh/config" do
  owner user
  group group
  action :touch
  mode '0600'
end

execute "echo 'StrictHostKeyChecking no' > #{user_dir}/.ssh/config" do
  not_if "grep '^StrictHostKeyChecking no$' #{user_dir}/.ssh/config"
end

template "#{user_dir}/.ssh/id_dsa" do
  action :create
  mode '0600'
  owner user
  group group
  cookbook "vision"
  source 'ssh_key.erb'
  variables :ssh_key => app[:app_source][:ssh_key]
  not_if do
    app[:app_source][:ssh_key].nil?
  end
end

Chef::Log.info("[END] Configure Git")
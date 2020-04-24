Chef::Log.info("[Start] Deploy Batman")

app = search("aws_opsworks_app").first

deploy_to = "#{node[:deploy][:to]}/#{app[:shortname]}"
keep_releases = node[:deploy][:keep_releases]
group = node[:deploy][:group]
user = node[:deploy][:user]

# If a migration is to be run, the chef-client symlinks the database configuration 
# file into the checkout (config/database.yml by default) and runs the migration command. 
# For a Ruby on Rails application, the migration_command is usually set to rake db:migrate.
migration = false
migrate_command = ""

# An array of directories (relative to the application root) to be removed from 
# a checkout before symbolic links are created. This attribute runs before create_dirs_before_symlink 
# and before symlink. Default value: %w{log tmp/pids public/system} (or the same as ["log", "tmp/pids", "public/system"].
# purge_before_symlink = ['log', 'tmp/pids', 'public/system']

# Create directories in the release directory before symbolic links are created. 
# This property runs after purge_before_symlink and before symlink.
# create_dirs_before_symlink = = ['tmp', 'public', 'config']

# Map files in a shared directory to the current release directory. The symbolic 
# links for these files are created before any migration is run. Use parentheses ( ) 
# around curly braces { } to ensure the contents within the curly braces are interpreted as a block and not as an empty Hash. Set to symlink_before_migrate({}) to prevent the creation of symbolic links.
symlink_before_migrate = {}

# Map files in a shared directory to their paths in the current release directory. 
# This property runs after create_dirs_before_symlink and purge_before_symlink.
# symlinks = {"system" => "public/system", "pids" => "tmp/pids", "log" => "log"}

#################

# Create deploy destination folder
directory "#{deploy_to}" do
  group group
  owner user
  mode "0775"
  action :create
  recursive true
end

## Deploy the App
deploy "#{deploy_to}" do
  provider Chef::Provider::Deploy.const_get("Timestamped")
  keep_releases keep_releases
  repository app[:app_source][:url]
  user user
  group group
  revision app[:app_source][:revision]
  migrate migration
  migration_command migrate_command
  environment app[:environment].to_hash  
  # purge_before_symlink purge_before_symlink
  # create_dirs_before_symlink create_dirs_before_symlink
  symlink_before_migrate symlink_before_migrate
  # symlinks symlinks
  action :deploy
  scm_provider :git
  enable_submodules true
  shallow_clone false


  before_migrate do
    execute "Install project dependencies" do
      command "yarn install --pure-lockfile"
      user user
      cwd release_path
    end
    
    execute "Build project" do
      command "yarn build"
      user user
      cwd release_path
    end
  end
  
  
  # before_restart do
  #   execute "copy botpress binary" do
  #     command "cp #{botpress_current_dir}/bp #{release_path}"
  #     user user
  #   end
  #   execute "copy bindings dir" do
  #     command "cp -R #{botpress_current_dir}/bindings #{release_path}"
  #     user user
  #   end
  #   execute "copy modules dir" do
  #     command "cp -R #{botpress_current_dir}/modules #{release_path}"
  #     user user
  #   end
  #   execute "copy storage dir" do
  #     command "cp -R #{botpress_current_dir}/data/storage #{release_path}/data"
  #     user user
  #   end
  #   execute "stop Batman" do
  #     command "pm2 stop bp 2> /dev/null || true"
  #   end
  # end
  # 
  # after_restart do    
  #   execute "start Batman" do
  #     command "pm2 start #{release_path}/bp"
  #   end
  #   execute "restart Nginx" do
  #     command "service nginx restart"
  #   end
  # end
end

Chef::Log.info("[END] Deploy Batman")
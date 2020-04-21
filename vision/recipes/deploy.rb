Chef::Log.info("[Start] Deploy Vision Bot")

app = search("aws_opsworks_app").first

# Chef::Log.info("#{app[:app_source][:ssh_key]}")
# Chef::Log.info("[Start] Vision bot deploy - URL")
# Chef::Log.info("#{app[:app_source][:url]}")
# Chef::Log.info("[Start] Vision bot deploy- VAR")
# Chef::Log.info("#{app[:environment][:EXTERNAL_URL]}")


deploy_to = "/srv/www/#{app[:shortname]}"
keep_releases = 5
group = "www-data"
user = "deploy"

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
# symlink_before_migrate = {}

# Map files in a shared directory to their paths in the current release directory. 
# This property runs after create_dirs_before_symlink and purge_before_symlink.
# symlinks = {"system" => "public/system", "pids" => "tmp/pids", "log" => "log"}

#################

deploy "#{deploy_to}" do
  provider Chef::Provider::Deploy::TimestampedDeploy
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
  # symlink_before_migrate symlink_before_migrate
  # symlinks symlinks
  action :deploy
  scm_provider :git
  enable_submodules true
  shallow_clone false

  

  # before_migrate do
  #   link_tempfiles_to_current_release
  # 
  #   if deploy[:application_type] == 'rails'
  #     if deploy[:auto_bundle_on_deploy]
  #       OpsWorks::RailsConfiguration.bundle(application, node[:deploy][application], release_path)
  #     end
  # 
  #     node.default[:deploy][application][:database][:adapter] = OpsWorks::RailsConfiguration.determine_database_adapter(
  #       application,
  #       node[:deploy][application],
  #       release_path,
  #       :force => node[:force_database_adapter_detection],
  #       :consult_gemfile => node[:deploy][application][:auto_bundle_on_deploy]
  #     )
  #     template "#{node[:deploy][application][:deploy_to]}/shared/config/database.yml" do
  #       cookbook "rails"
  #       source "database.yml.erb"
  #       mode "0660"
  #       owner node[:deploy][application][:user]
  #       group node[:deploy][application][:group]
  #       variables(
  #         :database => node[:deploy][application][:database],
  #         :environment => node[:deploy][application][:rails_env]
  #       )
  # 
  #       only_if do
  #         deploy[:database][:host].present?
  #       end
  #     end.run_action(:create)
  #   elsif deploy[:application_type] == 'aws-flow-ruby'
  #     OpsWorks::RailsConfiguration.bundle(application, node[:deploy][application], release_path)
  #   elsif deploy[:application_type] == 'php'
  #     template "#{node[:deploy][application][:deploy_to]}/shared/config/opsworks.php" do
  #       cookbook 'php'
  #       source 'opsworks.php.erb'
  #       mode '0660'
  #       owner node[:deploy][application][:user]
  #       group node[:deploy][application][:group]
  #       variables(
  #         :database => node[:deploy][application][:database],
  #         :memcached => node[:deploy][application][:memcached],
  #         :layers => node[:opsworks][:layers],
  #         :stack_name => node[:opsworks][:stack][:name]
  #       )
  #       only_if do
  #         File.exists?("#{node[:deploy][application][:deploy_to]}/shared/config")
  #       end
  #     end
  #   elsif deploy[:application_type] == 'nodejs'
  #     if deploy[:auto_npm_install_on_deploy]
  #       OpsWorks::NodejsConfiguration.npm_install(application, node[:deploy][application], release_path, node[:opsworks_nodejs][:npm_install_options])
  #     end
  #   end
  # 
  #   # run user provided callback file
  #   run_callback_from_file("#{release_path}/deploy/before_migrate.rb")
  # end
end
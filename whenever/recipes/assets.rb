Chef::Log.info("[Assets] Compile...")

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  bash "start-assets-#{application}" do
    layers = node[:opsworks][:instance][:layers]

    cwd "#{deploy[:deploy_to]}/current"
    user 'deploy'

    command('bundle exec rake assets:precompile')
    
  end
end

Chef::Log.info("[Assets] Compile..")

Chef::Log.info("[Start] Updating Cron by Whenever")

app = search("aws_opsworks_app").first

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  bash "update-crontab" do
    # layers = node[:opsworks][:instance][:layers]

    cwd "#{deploy[:deploy_to]}/current"
    user 'deploy'

    Chef::Log.info("Updating cron ...")

    code "bundle exec whenever --set environment=#{deploy[:rails_env]} --update-crontab #{app[:shortname]} --roles #{layers.join(',')}"
    only_if "cd #{deploy[:deploy_to]}/current && bundle show whenever"
  end
end

Chef::Log.info("[End] Updating Cron by Whenever")
Chef::Log.info("[Start] Deploy zeus staging")

sleep(2)

http_request 'deploy staging zeus circle' do
  # url "https://circleci.com/api/v1.1/project/github/Edools/zeus/tree/dev?circle-token=f22ba03ebad89e84d1b56297557bb8bb499f9d28"
  url "https://circleci.com/api/v1.1/project/github/Edools/zeus/tree/dev?circle-token=f22ba03ebad89e84d1b56297557bb8bb499f9d28&build_parameters[CIRCLE_JOB]=staging_deploy"
  action :post
end

Chef::Log.info("[End] Deploy zeus staging")

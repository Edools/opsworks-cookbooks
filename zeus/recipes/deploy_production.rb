Chef::Log.info("[Start] Deploy zeus production")

http_request 'deploy staging zeus circle' do
  url "https://circleci.com/api/v1.1/project/github/Edools/zeus/tree/zeus-production?circle-token=f22ba03ebad89e84d1b56297557bb8bb499f9d28"
  action :post
end

Chef::Log.info("[End] Deploy zeus production")
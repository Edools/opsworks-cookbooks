Chef::Log.info("[Start] Deploy hub production")

http_request 'deploy production hub circle' do
  url "https://circleci.com/api/v1.1/project/github/Edools/edools-docs/tree/master?circle-token=716cca5a76943991b6ded01f196e980b430b92ce"
  action :post
end

Chef::Log.info("[End] Deploy hub production")
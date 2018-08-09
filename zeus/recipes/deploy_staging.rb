Chef::Log.info("[Start] Deploy zeus staging")

http_request 'deploy staging zeus circle' do
  action(:post)
  
  url("https://circleci.com/api/v1.1/project/github/Edools/zeus/tree/dev?circle-token=f22ba03ebad89e84d1b56297557bb8bb499f9d28")
  
  message({ 
    'build_parameters' => { 'CIRCLE_JOB' => 'staging_deploy' } 
  }.to_json)
  
  headers({
    'Content-Type' => 'application/data'
  })
end

Chef::Log.info("[End] Deploy zeus staging")

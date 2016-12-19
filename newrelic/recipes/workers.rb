Chef::Log.info("[Start] Workers newrelic")

newrelic_yml_file = '/srv/www/core/current/config/newrelic.yml'

execute "move newrelic.yml to tmp" do
	command("mv #{newrelic_yml_file} #{newrelic_yml_file}.tmp")
end

file newrelic_yml_file do
  content '
common: &default_settings
  license_key: "62ba8700373589b340a692b6acad3432c1bb695a"
  app_name: Edools 3 (Workers)
  monitor_mode: true
  developer_mode: false
  log_level: info

  audit_log:
    enabled: false

  capture_params: false

  transaction_tracer:
    enabled: true
    transaction_threshold: apdex_f
    record_sql: raw
    stack_trace_threshold: 0.500

  error_collector:
    enabled: true
    capture_source: true
    ignore_errors: "ActionController::RoutingError,Sinatra::NotFound"

development:
  <<: *default_settings.
  monitor_mode: false
  developer_mode: true

test:
  <<: *default_settings
  monitor_mode: false

production:
  <<: *default_settings
  monitor_mode: true
  app_name: Edools 3 (Workers)

staging:
  <<: *default_settings
  monitor_mode: false
  app_name: Edools 3 (Staging)
'
end

Chef::Log.info("[Start] Workers newrelic")

require 'sidekiq'
require_relative 'sample_job'

redis_config = { url: 'redis://localhost:6379/0' }

Sidekiq.configure_server do |config|
  config.redis = redis_config
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end

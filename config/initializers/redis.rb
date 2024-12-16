require 'connection_pool'
redis_config = Rails.application.config_for(:redis)
REDIS = ConnectionPool.new(size: redis_config.pool_size) do
  Redis.new(url: redis_config.url)
end

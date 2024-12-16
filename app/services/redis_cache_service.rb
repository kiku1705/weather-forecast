# this service is to set and get data from cache 
class RedisCacheService
  def self.store_cache_data(cache_key, value, expiration_time)
    REDIS.with do |conn|
      conn.set(cache_key, value, ex: expiration_time)
    end
  end

  def self.get_cache_data(cache_key)
    REDIS.with do |conn|
      return conn.get(cache_key) if conn.exists(cache_key)
    end
    return nil
  end
end
module CacheAPI

  def capi_get_or_set(key, k, m)
    return k.send(m) if Rails.env.test?

    begin
      return $cache.get key
    rescue Memcached::NotFound
      v = k.send(m)
      $cache.set key, v
      return v
    end

  end

end

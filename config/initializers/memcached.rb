unless Rails.env.test?
  require 'memcached'
  $cache = Memcached.new("localhost:11211")
end

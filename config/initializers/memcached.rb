unless Rails.env.test?
  require 'memcached'
  memsrv = Rails.env.demo? ? '192.168.8.103:11211' : 'localhost:11211'
  $cache = Memcached.new(memsrv)
end

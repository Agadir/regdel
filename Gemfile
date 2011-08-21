source 'http://rubygems.org'

gem 'rails', :git => 'git://github.com/rails/rails.git', :branch => '3-1-stable'

gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'haml'
gem 'nested_set'
gem 'state_machine'
gem 'inherited_resources'

gem 'jquery-rails', '>= 1.0.12'

gem 'ruby-xslt', :require => 'xml/xslt'

group :development do
  gem 'memcached'
  gem 'rack-xsl', :require => 'rack/xsl'
end

group :test do
  gem 'rack-xsl', :require => 'rack/xsl'
  gem "shoulda"
  gem 'machinist', '>= 2.0.0.beta2' 
end

group :production do
#  gem 'rack-perftools_profiler', :require => 'rack/perftools_profiler'
  gem 'memcached'
  gem 'rack-xsl', :require => 'rack/xsl'
end
gem 'tidy_ffi'

gem 'rdiscount', ">= 1.6.8"
gem 'rack-rdiscount', ">= 0.0.2", :require => 'rack/rdiscount'
gem 'rack-contrib', :require => 'rack/contrib'
gem 'rack', :require => 'rack/contrib/config'
gem 'rack-rewrite'
gem 'sass'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

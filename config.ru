require 'xml/xslt'
require 'rack/xsl'
gem 'rdiscount', '=1.6.8'
require 'rack/rdiscount' if ENV['RACK_ENV'] == 'production'
#require '/var/www/dev/rack-rdiscount/lib/rack/rdiscount' unless ENV['RACK_ENV'] == 'production'
require 'rack/rdiscount' unless ENV['RACK_ENV'] == 'production'
require 'rack-rewrite'

myxslfile = File.dirname(__FILE__) + '/app/views/layouts/xsl/html_main.xsl'

prefix = '/demo/regdel'

use Rack::Config do |env|
  env['RACK_ENV'] = Rails.env
  env['RACK_MOUNT_PATH'] = prefix
  env['TS'] = Time.now.to_i
  #env['ORIG_PATH_INFO'] = env['PATH_INFO'].gsub(/\.mdwn$/,'.html')
  env['ORIG_PATH_INFO'] = env['PATH_INFO']
  env['USE_HTML_PARTIALS'] = 1
end

use Rack::XSL,
  :myxsl => XML::XSLT.new(),
  :noxsl => ['/raw/', '/s/js/', '/s/css/', '/s/img/', '/javascripts/', '/stylesheets/'],
  :passenv => ['PATH_INFO', 'RACK_MOUNT_PATH', 'RACK_ENV', 'ORIG_PATH_INFO', 'USE_HTML_PARTIALS'],
  :xslfile => File.open(myxslfile) {|f| f.read },
  :xslfilename => myxslfile,
  :excludehtml => false,
  :content_type => 'text/html',
  :cache_control => 'no-store',
  :reload => true,
  :tidy => {  :doctype => 'omit',
    :numeric_entities => 1,
    :drop_proprietary_attributes => 1,
    :preserve_entities => 0,
    :input_encoding => 'utf8',
    :char_encoding => 'utf8',
    :output_encoding => 'utf8',
    :error_file => '/tmp/tidyerr.txt',
    :force_output => 1,
    :output_xml => 1,
    :alt_text => '',
    :wrap => 0,
    :wrap_attributes => 0,
    :tidy_mark => 0,
    :logical_emphasis => 1,
  }

require ::File.expand_path('../config/environment',  __FILE__)

use Rack::Static, :urls => ["/stylesheets", "/javascripts"], :root => 'public'

run RegdelRails::Application

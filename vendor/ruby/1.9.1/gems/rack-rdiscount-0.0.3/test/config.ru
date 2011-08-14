require 'rubygems'
require '../lib/rack-rdiscount'
#require '../lib/rack-nolength'
#require '../lib/rack-finalcontentlength'



#use Rack::FinalContentLength
#use Rack::NoLength
use Rack::RackDiscount, :extension => 'mdwn'
use Rack::Static, :urls => ["/test.html","/test2.html"]

app = lambda { |env| [200, { 'Content-Type' => 'text/html' }, '**Hello World**'] }
run app

require 'regdel'
require 'rack/utils'
require 'xml/libxml'
require 'xml/libxslt'
require 'rexml/document'
gem 'rack-rewrite', '~> 0.2.0'
require 'rack-rewrite'

require 'helpers/rack/xslview'
require 'helpers/rack/nolength'
require 'helpers/rack/examplea'
require 'helpers/rack/finalcontentlength'




map "/" do

  use Rack::Rewrite do
      rewrite '/entry/new', '/s/xhtml/entry_all_form.html'
      rewrite %r{/entry/edit(.*)}, '/s/xhtml/entry_all_form.html'
      rewrite %r{/account/new(.*)}, '/s/xhtml/account_form.html'
      rewrite %r{/account/edit/(.*)}, '/s/xhtml/account_form.html?id=$1'
      rewrite '/', '/s/xhtml/welcome.html'
  end
  
  
  
  xslt = ::XML::XSLT.new()
  xslt.xsl = REXML::Document.new File.open('/var/www/dev/regdel/views/xsl/html_main.xsl')
  


  # These are processed in reverse order it seems
  use Rack::CommonLogger
  use Rack::FinalContentLength
  use Rack::XSLView, :myxsl => xslt
  #use Rack::ExampleA
  use Rack::NoLength
  run Regdel::Main
  #app = Sinatra::Application
end

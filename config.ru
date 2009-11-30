require 'regdel'
require 'rack/utils'
require 'xml/libxml'
require 'xml/libxslt'
require 'rexml/document'

require 'helpers/rack/xslview'
require 'helpers/rack/nolength'
require 'helpers/rack/examplea'
require 'helpers/rack/finalcontentlength'






xslt = ::XML::XSLT.new()
xslt.xsl = REXML::Document.new File.open('/var/www/dev/regdel/views/xsl/entries.xsl')

# These are processed in reverse order it seems
use Rack::FinalContentLength
use Rack::XSLView, :myxsl => xslt
use Rack::ExampleA
use Rack::NoLength


app = Sinatra::Application
run app

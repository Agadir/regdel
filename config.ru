require 'regdel'
require 'rack/utils'
require 'xml/libxml'
require 'xml/libxslt'
require 'rexml/document'

module Rack
  class CleanHeaders
    def initialize(app)
      @app = app
    end

    def call(env)
        status, headers, response = @app.call(env)
        headers.delete('Content-Length')
        [status, headers, response]
    end
  end
end
module Rack
  class This
    def initialize(app)
      @app = app
    end

    def call(env)
        status, headers, @response = @app.call(env)
        [status, headers, self]
    end
    def each(&block)
        @response.each { |x|
            x.gsub!('</div>','just saying hi</div>')
            yield x
        }
    end
  end
end

module Rack
  class XSLView
    def initialize(app, options={})
      @app = app
      @options = {:myxsl => nil}.merge(options)
      if @options[:myxsl] == nil
        @xslt = ::XML::XSLT.new()
        @xslt.xsl = '/var/www/dev/regdel/views/xsl/identity.xsl'
      else
        @xslt = @options[:myxsl]
      end
    end

    def call(env)
        status, headers, @response = @app.call(env)
        [status, headers, self]
    end
    def each(&block)
        @response.each { |x|
            if x.include? "<_R_"
              @xslt.xml = x
              yield @xslt.serve
            else
                yield x
            end
        }
    end
  end
end

module Rack
  class MyCL
    def initialize(app)
      @app = app
    end

    def call(env)
        status, headers, response = @app.call(env)
        response_body = ""
        response.each { |part| response_body += part }

        headers["Content-Length"] = response_body.length.to_s
        #puts response_body.length.to_s
        [status, headers, response_body]
    end
  end
end


xslt = ::XML::XSLT.new()
xslt.xsl = REXML::Document.new File.open('/var/www/dev/regdel/views/xsl/entries.xsl')

# These are processed in reverse order it seems
use Rack::MyCL
use Rack::XSLView, :myxsl => xslt
use Rack::This
use Rack::CleanHeaders

#Rack::XSLView.config

app = Sinatra::Application
run app

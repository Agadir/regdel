
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


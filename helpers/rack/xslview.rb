
module Rack
  class XSLView
    def initialize(app, options={})
      @my_path_info = String.new
      @app = app
      @options = {:myxsl => nil}.merge(options)
      if @options[:myxsl] == nil
        @xslt = ::XML::XSLT.new()
        @xslt.xsl = 'http://github.com/docunext/1bb02b59/raw/master/output.xhtml10.xsl'
      else
        @xslt = @options[:myxsl]
      end
    end

    def call(env)
        if ((env["PATH_INFO"].include? "/raw/") || (env["PATH_INFO"].include? "/s/js/") || (env["PATH_INFO"].include? "/s/css/"))
            @app.call(env)
        else
          # This is very picky here - needs "#{var}" for param value
            if (mp = env["PATH_INFO"])
              @xslt.parameters = { "my_path_info" => "#{mp}" }
            end
            status, headers, @response = @app.call(env)
            [status, headers, self]
        end
    end
    def each(&block)
        @response.each { |x|
            if ((x.include? "<html") || !(x.include? "<"))
                yield x
            else
              @xslt.xml = x
              yield @xslt.serve
            end
        }
    end
  end
end


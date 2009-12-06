
module Rack
  class XSLView
    def initialize(app, options={})
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
        @my_path_info = env["PATH_INFO"] 
        if ((@my_path_info.include? "/raw/") || (@my_path_info.include? "/s/js/"))
            @app.call(env)
        else
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
              @xslt.parameters = { "path_info" => @my_path_info }
              yield @xslt.serve
            end
        }
    end
  end
end


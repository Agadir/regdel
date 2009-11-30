require 'regdel'
require 'rack/utils'

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
            x.gsub('</body>','just saying hi</body>')
            yield x
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


# These are processed in reverse order it seems
use Rack::MyCL
use Rack::This
use Rack::CleanHeaders


app = Sinatra::Application
run app

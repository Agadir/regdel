module Rack
  class FinalContentLength
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

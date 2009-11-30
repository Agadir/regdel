module Rack
  class NoLength
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

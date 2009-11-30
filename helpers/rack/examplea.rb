module Rack
  class ExampleA
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

# Copyright: Savonix Corporation, 2009
# Author:    Albert Lash
# License:   MIT
require "rdiscount"

module Rack
  class RackDiscount
    def initialize(app, options)
      @my_path_info = String.new
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)
      original_response = Array[status, headers, body]
      excluded_status = Array[204, 301, 302, 304]
      return original_response if excluded_status.include?(status) || body.nil?

      return original_response unless headers["Content-Type"].to_s == 'text/plain'
      mdwn = getResponse(body)
      body.close if body.respond_to?(:close)
      
      newbody = '<div id="page-content">' + RDiscount.new(mdwn).to_html + '</div>'
      # If we've made it this far, we can alter the headers
      headers.delete('Content-Length')
      headers['Content-Length'] = newbody.length.to_s
      headers.delete('Content-Type')
      headers['Content-Type'] = 'text/html'

      [status, headers, newbody] 
    end

    private
      def getResponse(body)
        return body unless body.respond_to?(:each)
        newbody = []
        body.each { |part|
          newbody << part.to_s
        }
        return newbody.join('')
      end
      def wrap(tag='div')
        #
      end
  end
end


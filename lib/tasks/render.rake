namespace :render do

  task :partials => :environment do
    request = { 
     "SERVER_PROTOCOL" => "http", 
     "REQUEST_URI" => "/",
     "SERVER_NAME" => "localhost", 
     "SERVER_PORT" => 80
    }
    app = RegdelRails::Application
    view = ActionView::Base.new(app.config.paths.app.views.first)
    view.config = Rails.application.config.action_controller
    view.extend ApplicationController._helpers
    view.controller = ActionController::Base.new
    view.controller.request = ActionDispatch::Request.new(request)
    view.controller.response = ActionDispatch::Response.new
    view.controller.headers = Rack::Utils::HeaderHash.new
    view.class_eval do
      include ApplicationHelper
      include app.routes.url_helpers
    end
    view.controller.class_eval do
      include ApplicationHelper
      include app.routes.url_helpers
    end
    Dir["#{Rails.root}/app/views/layouts/_*.html.haml"].each do |file_name|
      puts file_name
      if File.exist?(file_name)
        new_file = file_name.gsub("#{Rails.root}/app/views/layouts/_",'app/views/layouts/xsl/html/').gsub('.haml','')
        output = view.render file_name.gsub("#{Rails.root}/app/views/layouts/_",'layouts/').gsub('.html.haml','')
        f = File.new(new_file, "w") 
        f.write(output)
      end
    end
  end
end

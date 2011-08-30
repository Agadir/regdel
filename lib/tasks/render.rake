namespace :render do

  task :partials => :environment do
    
    app = RegdelRails::Application
    controller = AccountsController.new
    view = ActionView::Base.new(app.config.paths.app.views.first)
    view.class_eval do
      include ApplicationHelper
      include app.routes.url_helpers
    end
    Dir["#{Rails.root}/app/views/layouts/_*.html.haml"].each do |file_name|
      puts file_name
      if File.exist?(file_name)
        new_file = file_name.gsub('.haml','')
        output = view.render 'layouts/header'
        f = File.new(new_file, "w") 
        f.write(output)
      end
    end
  end
end

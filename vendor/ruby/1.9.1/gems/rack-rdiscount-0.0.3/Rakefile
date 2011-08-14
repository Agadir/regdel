require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rack-rdiscount"
    gem.summary = %{Markdown rack middleware.}
    gem.description = %Q{A rack middleware for converting markdown to html.}
    gem.email = 'albert.lash@docunext.com'
    gem.homepage = 'http://www.docunext.com/'
    gem.authors = ['Albert Lash']
    gem.rubyforge_project = ''
  end
  Jeweler::GemcutterTasks.new
  Jeweler::RubyforgeTasks.new do |rubyforge|
    rubyforge.doc_task = 'rdoc'
  end
rescue LoadError
  puts 'Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler'
end


require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rack-rewrite #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

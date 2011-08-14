# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ruby-xslt}
  s.version = "0.9.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Gregoire Lejeune"]
  s.date = %q{2010-11-25}
  s.description = %q{Ruby/XSLT is a simple XSLT class based on libxml <http://xmlsoft.org/> and libxslt <http://xmlsoft.org/XSLT/>}
  s.email = %q{gregoire.lejeune@free.fr}
  s.extensions = ["ext/xslt_lib/extconf.rb"]
  s.files = ["test/test.rb", "ext/xslt_lib/extconf.rb"]
  s.homepage = %q{http://github.com/glejeune/ruby-xslt}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Ruby/XSLT is a simple XSLT class based on libxml <http://xmlsoft.org/> and libxslt <http://xmlsoft.org/XSLT/>}
  s.test_files = ["test/test.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

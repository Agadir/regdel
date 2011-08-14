# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rack-rdiscount}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Albert Lash"]
  s.date = %q{2011-07-10}
  s.description = %q{A rack middleware for converting markdown to html.}
  s.email = %q{albert.lash@docunext.com}
  s.homepage = %q{http://www.docunext.com/}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{}
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Markdown rack middleware.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

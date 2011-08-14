# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rack-rewrite}
  s.version = "1.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["John Trupiano"]
  s.date = %q{2010-10-01}
  s.description = %q{A rack middleware for enforcing rewrite rules. In many cases you can get away with rack-rewrite instead of writing Apache mod_rewrite rules.}
  s.email = %q{jtrupiano@gmail.com}
  s.files = ["test/rack-rewrite_test.rb", "test/rule_test.rb", "test/test_helper.rb"]
  s.homepage = %q{http://github.com/jtrupiano/rack-rewrite}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{johntrupiano}
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{A rack middleware for enforcing rewrite rules}
  s.test_files = ["test/rack-rewrite_test.rb", "test/rule_test.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

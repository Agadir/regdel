# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tidy_ffi}
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Eugene Pimenov"]
  s.date = %q{2010-06-12}
  s.description = %q{Tidy library interface via FFI}
  s.email = %q{libc@libc.st}
  s.files = ["test/test_helper.rb", "test/test_lowlevel.rb", "test/test_options.rb", "test/test_simple.rb"]
  s.homepage = %q{http://github.com/libc/tidy_ffi}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{tidy-ffi}
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Tidy library interface via FFI}
  s.test_files = ["test/test_helper.rb", "test/test_lowlevel.rb", "test/test_options.rb", "test/test_simple.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ffi>, [">= 0.3.5"])
    else
      s.add_dependency(%q<ffi>, [">= 0.3.5"])
    end
  else
    s.add_dependency(%q<ffi>, [">= 0.3.5"])
  end
end

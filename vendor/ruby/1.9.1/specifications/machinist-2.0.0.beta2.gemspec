# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{machinist}
  s.version = "2.0.0.beta2"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pete Yandell"]
  s.date = %q{2010-07-06}
  s.email = %q{pete@notahat.com}
  s.files = ["spec/active_record_spec.rb", "spec/blueprint_spec.rb", "spec/exceptions_spec.rb", "spec/inheritance_spec.rb", "spec/machinable_spec.rb", "spec/shop_spec.rb", "spec/spec_helper.rb", "spec/support/active_record_environment.rb", "spec/warehouse_spec.rb"]
  s.homepage = %q{http://github.com/notahat/machinist}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Fixtures aren't fun. Machinist is.}
  s.test_files = ["spec/active_record_spec.rb", "spec/blueprint_spec.rb", "spec/exceptions_spec.rb", "spec/inheritance_spec.rb", "spec/machinable_spec.rb", "spec/shop_spec.rb", "spec/spec_helper.rb", "spec/support/active_record_environment.rb", "spec/warehouse_spec.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

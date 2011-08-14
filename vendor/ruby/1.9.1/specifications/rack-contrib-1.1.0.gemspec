# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rack-contrib}
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["rack-devel"]
  s.date = %q{2010-10-19}
  s.description = %q{Contributed Rack Middleware and Utilities}
  s.email = %q{rack-devel@googlegroups.com}
  s.files = ["test/spec_rack_accept_format.rb", "test/spec_rack_access.rb", "test/spec_rack_backstage.rb", "test/spec_rack_callbacks.rb", "test/spec_rack_common_cookies.rb", "test/spec_rack_config.rb", "test/spec_rack_contrib.rb", "test/spec_rack_cookies.rb", "test/spec_rack_csshttprequest.rb", "test/spec_rack_deflect.rb", "test/spec_rack_evil.rb", "test/spec_rack_expectation_cascade.rb", "test/spec_rack_garbagecollector.rb", "test/spec_rack_host_meta.rb", "test/spec_rack_jsonp.rb", "test/spec_rack_lighttpd_script_name_fix.rb", "test/spec_rack_mailexceptions.rb", "test/spec_rack_nested_params.rb", "test/spec_rack_not_found.rb", "test/spec_rack_post_body_content_type_parser.rb", "test/spec_rack_proctitle.rb", "test/spec_rack_profiler.rb", "test/spec_rack_relative_redirect.rb", "test/spec_rack_response_cache.rb", "test/spec_rack_response_headers.rb", "test/spec_rack_runtime.rb", "test/spec_rack_sendfile.rb", "test/spec_rack_simple_endpoint.rb", "test/spec_rack_static_cache.rb", "test/spec_rack_try_static.rb"]
  s.homepage = %q{http://github.com/rack/rack-contrib/}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Contributed Rack Middleware and Utilities}
  s.test_files = ["test/spec_rack_accept_format.rb", "test/spec_rack_access.rb", "test/spec_rack_backstage.rb", "test/spec_rack_callbacks.rb", "test/spec_rack_common_cookies.rb", "test/spec_rack_config.rb", "test/spec_rack_contrib.rb", "test/spec_rack_cookies.rb", "test/spec_rack_csshttprequest.rb", "test/spec_rack_deflect.rb", "test/spec_rack_evil.rb", "test/spec_rack_expectation_cascade.rb", "test/spec_rack_garbagecollector.rb", "test/spec_rack_host_meta.rb", "test/spec_rack_jsonp.rb", "test/spec_rack_lighttpd_script_name_fix.rb", "test/spec_rack_mailexceptions.rb", "test/spec_rack_nested_params.rb", "test/spec_rack_not_found.rb", "test/spec_rack_post_body_content_type_parser.rb", "test/spec_rack_proctitle.rb", "test/spec_rack_profiler.rb", "test/spec_rack_relative_redirect.rb", "test/spec_rack_response_cache.rb", "test/spec_rack_response_headers.rb", "test/spec_rack_runtime.rb", "test/spec_rack_sendfile.rb", "test/spec_rack_simple_endpoint.rb", "test/spec_rack_static_cache.rb", "test/spec_rack_try_static.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, [">= 0.9.1"])
      s.add_development_dependency(%q<test-spec>, [">= 0.9.0"])
      s.add_development_dependency(%q<tmail>, [">= 1.2"])
      s.add_development_dependency(%q<json>, [">= 1.1"])
    else
      s.add_dependency(%q<rack>, [">= 0.9.1"])
      s.add_dependency(%q<test-spec>, [">= 0.9.0"])
      s.add_dependency(%q<tmail>, [">= 1.2"])
      s.add_dependency(%q<json>, [">= 1.1"])
    end
  else
    s.add_dependency(%q<rack>, [">= 0.9.1"])
    s.add_dependency(%q<test-spec>, [">= 0.9.0"])
    s.add_dependency(%q<tmail>, [">= 1.2"])
    s.add_dependency(%q<json>, [">= 1.1"])
  end
end

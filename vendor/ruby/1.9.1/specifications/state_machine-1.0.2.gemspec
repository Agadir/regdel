# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{state_machine}
  s.version = "1.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aaron Pfeifer"]
  s.date = %q{2011-08-10}
  s.description = %q{Adds support for creating state machines for attributes on any Ruby class}
  s.email = %q{aaron@pluginaweek.org}
  s.files = ["test/files/en.yml", "test/files/switch.rb", "test/functional/state_machine_test.rb", "test/test_helper.rb", "test/unit/assertions_test.rb", "test/unit/branch_test.rb", "test/unit/callback_test.rb", "test/unit/error_test.rb", "test/unit/eval_helpers_test.rb", "test/unit/event_collection_test.rb", "test/unit/event_test.rb", "test/unit/helper_module_test.rb", "test/unit/integrations/active_model_test.rb", "test/unit/integrations/active_record_test.rb", "test/unit/integrations/base_test.rb", "test/unit/integrations/data_mapper_test.rb", "test/unit/integrations/mongo_mapper_test.rb", "test/unit/integrations/mongoid_test.rb", "test/unit/integrations/sequel_test.rb", "test/unit/integrations_test.rb", "test/unit/invalid_event_test.rb", "test/unit/invalid_parallel_transition_test.rb", "test/unit/invalid_transition_test.rb", "test/unit/machine_collection_test.rb", "test/unit/machine_test.rb", "test/unit/matcher_helpers_test.rb", "test/unit/matcher_test.rb", "test/unit/node_collection_test.rb", "test/unit/path_collection_test.rb", "test/unit/path_test.rb", "test/unit/state_collection_test.rb", "test/unit/state_context_test.rb", "test/unit/state_machine_test.rb", "test/unit/state_test.rb", "test/unit/transition_collection_test.rb", "test/unit/transition_test.rb"]
  s.homepage = %q{http://www.pluginaweek.org}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{State machines for attributes}
  s.test_files = ["test/files/en.yml", "test/files/switch.rb", "test/functional/state_machine_test.rb", "test/test_helper.rb", "test/unit/assertions_test.rb", "test/unit/branch_test.rb", "test/unit/callback_test.rb", "test/unit/error_test.rb", "test/unit/eval_helpers_test.rb", "test/unit/event_collection_test.rb", "test/unit/event_test.rb", "test/unit/helper_module_test.rb", "test/unit/integrations/active_model_test.rb", "test/unit/integrations/active_record_test.rb", "test/unit/integrations/base_test.rb", "test/unit/integrations/data_mapper_test.rb", "test/unit/integrations/mongo_mapper_test.rb", "test/unit/integrations/mongoid_test.rb", "test/unit/integrations/sequel_test.rb", "test/unit/integrations_test.rb", "test/unit/invalid_event_test.rb", "test/unit/invalid_parallel_transition_test.rb", "test/unit/invalid_transition_test.rb", "test/unit/machine_collection_test.rb", "test/unit/machine_test.rb", "test/unit/matcher_helpers_test.rb", "test/unit/matcher_test.rb", "test/unit/node_collection_test.rb", "test/unit/path_collection_test.rb", "test/unit/path_test.rb", "test/unit/state_collection_test.rb", "test/unit/state_context_test.rb", "test/unit/state_machine_test.rb", "test/unit/state_test.rb", "test/unit/transition_collection_test.rb", "test/unit/transition_test.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<appraisal>, ["~> 0.3.8"])
      s.add_development_dependency(%q<ruby-graphviz>, ["~> 1.0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<appraisal>, ["~> 0.3.8"])
      s.add_dependency(%q<ruby-graphviz>, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<appraisal>, ["~> 0.3.8"])
    s.add_dependency(%q<ruby-graphviz>, ["~> 1.0"])
  end
end

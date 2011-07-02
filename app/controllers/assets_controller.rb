class AssetsController < InheritedResources::Base
  defaults :resource_class => Asset, :collection_name => 'accounts', :instance_name => 'account'
end

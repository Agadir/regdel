class AssetsController < AccountsController
  defaults :resource_class => Asset, :collection_name => 'accounts', :instance_name => 'account'
end

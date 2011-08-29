class OthersController < AccountsController
  defaults :resource_class => Other, :collection_name => 'accounts', :instance_name => 'account'
end

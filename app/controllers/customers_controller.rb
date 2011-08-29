class CustomersController < AccountsController
  defaults :resource_class => Customer, :collection_name => 'accounts', :instance_name => 'account'
end

class RevenuesController < AccountsController
  defaults :resource_class => Revenue, :collection_name => 'accounts', :instance_name => 'account'
end

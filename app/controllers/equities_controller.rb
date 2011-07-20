class EquitiesController < AccountsController
  defaults :resource_class => Equity, :collection_name => 'accounts', :instance_name => 'account'
end

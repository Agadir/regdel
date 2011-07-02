class LiabilitiesController < AccountsController
  defaults :resource_class => Liability, :collection_name => 'accounts', :instance_name => 'account'
end

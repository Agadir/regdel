class BankAccountsController < InheritedResources::Base
  defaults :resource_class => BankAccount, :collection_name => 'accounts', :instance_name => 'account'
end

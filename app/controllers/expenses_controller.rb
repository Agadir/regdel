class ExpensesController < AccountsController
  defaults :resource_class => Expense, :collection_name => 'accounts', :instance_name => 'account'
end

class CreditCardsController < LiabilitiesController
  defaults :resource_class => CreditCard, :collection_name => 'accounts', :instance_name => 'account'
end

class CurrentAssetsController < AssetsController
  defaults :resource_class => CurrentAsset, :collection_name => 'accounts', :instance_name => 'account'
end

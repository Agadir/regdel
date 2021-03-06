RegdelRails::Application.routes.draw do
  
  get "report/index"

  get "report/income"

  get "report/balance"

  get "report/cash_flow"

  resources :customers
  resources :vendors
  resources :entries do
    collection do
      get 'write_check'
      get 'transfer_funds'
      get 'create_invoice'
    end
  end
  resources :accounts do
    resources :entries
    member do
      get 'hide'
      get 'unhide'
    end
  end
  resources :bank_accounts
  resources :equities
  resources :current_assets
  resources :current_liabilities
  resources :liabilities
  resources :revenues
  resources :others
  resources :receivables
  resources :payables
  resources :credit_cards
  resources :expenses
  resources :checks
  resources :transfers
  resources :invoices

  #mount Beast::Engine => '/beast'

  #match 'accounts/:id/new' => 'accounts#new', :as => :new_sub_account

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "accounts#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'

  resources :assets, :as => 'products'
end

Rails.application.routes.draw do
  resources :parcels, only: [:create, :update, :destroy, :show]
  # resources :users, only: [:new, :create, :edit, :update]

  root 'pages#home'
  # match '/signup', to: 'users#edit', via: 'get'
  match '/about', to: 'pages#about', via: 'get'
  match '/profile', to: 'users#profile', via: 'get'
  match '/profile', to: 'users#save', via: 'patch'
  match '/login', to: 'users#login_form', via: 'get'
  match '/login', to: 'users#login', via: 'post'
  match '/login', to: 'users#logout', via: 'delete'
  match '/recovery/new', to: 'users#recovery_form', via: 'get'
  match '/recovery', to: 'users#recovery', via: 'post'
  match '/recovery', to: 'users#new_password_form', via: 'get'
  match '/recovery', to: 'users#new_password', via: 'patch'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

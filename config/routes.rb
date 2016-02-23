Rails.application.routes.draw do
  root 'homes#index'

  resources :hotels do
    resources :menus do
      get :view_menu, :on => :collection
      resources :menu_items
    end
     resources :delivery_areas do
    get "delete"
  end
    post 'rating', to:'homes#create_rating'
    get 'rating/show', to:'homes#show_rating'
  end
  
  resources :cities do
    get "delete"
    resources :areas do
    get "delete"
  end
  end
  
  devise_for :users

  resources :users, only: [:index, :edit, :update, :show]


  resources :homes do
    get :hotel_list, :on => :collection
  end
  get 'homes/hotel_list', to: 'homes#hotel_list'
  get 'add_order_item', to: 'menus#add_order_item'
  get 'reduce_order_item', to: 'menus#reduce_order_item'
  get 'confirm_order', to: 'menus#confirm_order'
  get 'delete_order_item', to: 'menus#delete_order_item'

  
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

Rails.application.routes.draw do
  get 'lastseen/new'

  root 'homes#index'
  resources :orders do
  get "order_status_update"
  get "auth_order"
 
  end
  resources :notifications
 
  resources :hotels do
    get 'add_order_item'
    get 'reduce_order_item'
    get 'confirm_order'
    get 'delete_order_item'
    get 'placed_order'
    get 'update_status'
    get "auth_hotel"
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
  get "authorize_hotels", to: 'hotels#authorized_hotels'  
  get 'process_order', to:'orders#process_order'
  
end

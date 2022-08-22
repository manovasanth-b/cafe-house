Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # sign/signout routes
  get "sessions" => "user_sessions#new", as: :view_login
  post "sessions/login" => "user_sessions#create", as: :request_login
  delete "sessions/logout" => "user_sessions#destroy", as: :request_logout

  # register routes
  get "user/register" => "users#index", as: :view_register
  post "user/register" => "users#create", as: :request_register

  # home routes
  root to: "home#index", as: :view_welcome
  get "menu" => "menu_categories#index", as: :view_home
  get "clerk/home" => "clerks#index", as: :view_clerk_home

  # Menu Item Routes have view and request
  get "menu/item/new/view" => "menu_categories#create_menu_item_view", as: :view_create_menu_item
  post "menu/item/edit/view" => "menu_categories#edit_menu_item_view", as: :view_edit_menu_item
  post "menu/item/new" => "menu_items#create", as: :request_create_menu_item
  post "menu/item/update" => "menu_items#update_menu_item", as: :request_edit_menu_item

  post "menu/category/edit" => "menu_categories#edit_menu_category", as: :request_edit_menu_category
  delete "menu/category/delete" => "menu_categories#destroy", as: :request_delete_menu_category
  delete "menu/item/delete" => "menu_items#delete_menu_item", as: :request_delete_menu_item

  # order items routes
  get "orders" => "orders#index", as: :view_orders
  get "orders/open" => "orders#view_clerk_open_orders", as: :view_clerk_open_orders
  put "orders/change/stage" => "orders#change_order_status", as: :request_change_order_stage
  post "order/item/new" => "orders#create_order", as: :request_create_order_item

  # check out routes
  get "checkout/view" => "check_out#index", as: :view_check_out
  post "order/place" => "check_out#place_order", as: :request_change_order_status

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

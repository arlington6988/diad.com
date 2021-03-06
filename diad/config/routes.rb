Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'diad#index'
  get 'diad/news' => 'diad#news'
  get 'diad/tour' => 'diad#tour'
  get 'diad/music' => 'diad#music'
  get 'diad/musicsimple' => 'diad#musicsimple'
  get 'diad/videos' => 'diad#videos'
  get 'diad/store/rmfromcart' => 'diad#rmfromcart'
  get 'diad/store/viewcart' => 'diad#viewcart'
  get 'diad/store/addtocart' => 'diad#itemtocart'
  get 'diad/store/tender' => 'diad#tender'
  get 'diad/store/thankyou' => 'diad#thankyou'
  post "/diad/store/checkout" => "charges#charge_card"
  get 'diad/products' => 'diad#items'
  get 'diad/photos' => 'diad#photos'
  get 'diad/download' => 'diad#download'
  get 'diad/about' => 'diad#about'
  get "/log-in" => "sessions#new"
  post "/log-in" => "sessions#create"
  get "/log-out" => "sessions#destroy", as: :log_out
  resources :users
  post "users/new" => "users#create"
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

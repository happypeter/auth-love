AuthLove::Application.routes.draw do  

  get "log_in" => "sessions#new", :as => "log_in"  # if you use "peters/new" rather than "peters#new", error: peters uninitilized
  # post "log_in" => "peter#new", :as => "log_in"  
  # if you use POST to sent '/login', you need the above line, otherwise you
  # get a strange error: No route matches "/log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"  
  match "about" => "nav#about", :as => "about"
  match "markdown" => "nav#markdown", :as => "markdown"
  match "post_vote" =>"posts#vote"
  match "comment_vote" =>"comments#vote"
  get "sign_up" => "users#new", :as => "sign_up"  

  root :to => "posts#index"  
  
  resources :users do
    resources :posts
  end
  resources :sessions
  resources :nav
  resources :password_resets
  resources :posts do
    resources :comments
  end
  resources :comments ## will this confilcts with about nested one
  get ':name' => 'users#show', :as => 'user_home'
end  
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'

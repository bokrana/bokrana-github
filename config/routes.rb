Bokrana::Application.routes.draw do
  mount RailsAdmin::Engine => '/aimanox', as: 'rails_admin'
root :to => "pages#home"
get "/login"=>'access#login'
delete '/logout' => 'access#logout'
get "/restor_password" => 'access#restor_password'
post "/restore_email" => "access#restore_email"
get '/me' => 'home#me'
get '/:id/live_notification' => 'pages#live_notification'
get '/search' => 'pages#search', as: :search
get "/autocomplete" => 'pages#autocomplete' 
post "/subscribe" => 'pages#subscribe', as: :subscribe
get "/terms" => 'pages#terms'
resources :passionates  , :path => ""
resources :passion_passionates , :only => [:edit,:update,:destroy]
resources :passions   do
get 'new_passion_confirm'
resources :passion_passionates , :only => [:new,:create]
#get :autocomplete, :on => :collection
# resources :comments , :path => '' , :path_names => { :new => 'new' } , except: :index
end

get '/access/activate_url'
post 'access/attempt_login'

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

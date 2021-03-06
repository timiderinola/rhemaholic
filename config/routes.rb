Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  resources :sessions,              only: [:new, :create, :destroy]
  resources :account_activations,   only: [:edit]
  resources :password_resets,       only: [:new, :create, :edit,:update]
  resources 'contacts', only: [:new, :create]

  resources :users do
    member do
      get 'following', as: :leaders
      get :followers
    end
  end


  resources :microposts do
    resources :comments, :only => [:create, :destroy]
  end

  root to: 'static_pages#home'

  get '/signup', to: 'users#new', as: 'signup'
  get '/signin', to: 'sessions#new', as: 'signin'
  delete '/signout', to: 'sessions#destroy', as: 'signout'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'contacts#new'
  post 'follow/:id', to: 'users#follow', as: 'follow_user'
  post 'unfollow/:id', to: 'users#unfollow', as: 'unfollow_user'

  get '/:id', to: 'users#show', as: :slug

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
  #   resources :long_posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

Rails.application.routes.draw do

  devise_for :users, :controllers => {:registrations => 'registrations'}
  resources :users do
    resources :authentications
  end
  resources :users
  resources :tasks
  resources :authentications
  resources :messages
  resources :reviews
  resources :tasks do
    resources :notes
  end

  root 'pages#home'
  get '/contact', :to => 'pages#contact'
  get '/fontawesome', :to => 'pages#fontawesomeoptions'
  get '/about', :to => 'pages#about'
  get '/help', :to => 'pages#help'
  get '/signup', :to => 'users#new'
  get 'riorunner', :to => 'pages#riorunner'
  get '/users/sign_up', :to => 'devise/registrations#new'
  get '/posttask', :to => 'pages#posttask'
  get '/myriorunner/:id', :to => 'users#my_rio_runner', as: 'myriorunner'
  get '/mymessages/:id', :to => 'messages#my_messages', as: 'mymessages'
  get '/messages/inbox/:id', :to => 'messages#rr_inbox', as: 'inbox'
  get '/messages/sent/:id', :to => 'messages#rr_sent', as: 'sent'
  get '/messages/deleted/:id', :to => 'messages#rr_deleted', as: 'deleted'
  get '/mytasks/:id', :to => 'tasks#my_tasks', as: 'mytasks'
  match 'tagged', to: 'tasks#tagged', :as => 'tagged', via: 'get'
  get 'tags/:tag', to: 'tasks#index', as: :tag
  get "tasks/tags" => "tasks#tags", :as => :tags
  get '/update_task_with_runner/:id', :to => 'tasks#update_task_with_runner', as: 'update_task_with_runner'
  get '/update_autotask_with_runner/:id', :to => 'tasks#update_autotask_with_runner', as: 'update_autotask_with_runner'
  get '/taskconfirmation/:id', :to => 'messages#taskconfirmation', as: 'taskconfirmation'
  match 'auth/:provider/callback', to: 'authentications#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
  get '/markasdeleted/:id', :to => 'messages#markasdeleted', as: 'markasdeleted'
  get '/users/edit/:id', :to => 'users#edit', as: 'useredit'
  get '/addpaymentinformationtotask/:id', :to => 'users#add_payment_info', as: 'addpaymentinfo'
  get '/taskcompletion/:id', :to => 'tasks#task_completion', as: 'taskcompletion'

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

Adapp::Application.routes.draw do
  
  devise_for :users
  root :to => 'visitors#new'
  #root "visitors#new"

  resources :projects do
  	member do
      get 'digestate', 'chp', 'upgrading'
    end
  end

  resources :feedstocks
  get "calculations/new"

  

  
  match ':controller(/:action(/:id))', :via => [:get, :post]
  
end

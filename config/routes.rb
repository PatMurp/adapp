Adapp::Application.routes.draw do
  
  ActiveAdmin.routes(self)
  devise_for :users
  root :to => 'visitors#new'

  resources :projects do
  	member do
      get 'digestate', 'chp', 'upgrading', 'carbon', 'report'
    end
  end

  resources :feedstocks
  #get "calculations/new"

  

  
  match ':controller(/:action(/:id))', :via => [:get, :post]
  
end

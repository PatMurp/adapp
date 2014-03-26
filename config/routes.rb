Adapp::Application.routes.draw do
  
  root :to => 'visitors#new'
  #root "visitors#new"

  resources :projects do
      get 'digestate',on: :member
      get 'chp', on: :member
  end

  resources :feedstocks
  get "calculations/new"

  

  
  match ':controller(/:action(/:id))', :via => [:get, :post]
  
end

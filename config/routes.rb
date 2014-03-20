Adapp::Application.routes.draw do
  
  root :to => 'visitors#new'
  #root "visitors#new"

  resources :projects
  resources :feedstocks
  get "calculations/new"

  # post "feedstock/substrate"

  # get "feedstock/biogas"
  # get "feedstock/substrate"
  #get "feedstock/digestate"

  # get "fuel/chp"
  # get "fuel/upgrade"
  # get "fuel/carbon"

  
  match ':controller(/:action(/:id))', :via => [:get, :post]
  
end

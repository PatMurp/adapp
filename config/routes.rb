Adapp::Application.routes.draw do
  root :to => 'visitors#new'
  #root "visitors#new"

  resources :feedstocks

  # post "feedstock/substrate"

  # get "feedstock/biogas"
  # get "feedstock/substrate"
  get "feedstock/digestate"

  # get "fuel/chp"
  # get "fuel/upgrade"
  # get "fuel/carbon"

  # !!!  default route delete this route eventually 
  match ':controller(/:action(/:id))', :via => :get
  
end

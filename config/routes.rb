Adapp::Application.routes.draw do
  #root :to => 'visitors#new'

  root "visitors#new"

  get "feedstock/biogas"
  get "feedstock/substrate"
  get "feedstock/digestate"

  get "fuel/chp"
  get "fuel/upgrade"
  get "fuel/carbon"
  
end

Intersection::Application.routes.draw do
  ActiveAdmin.routes(self)


  resources :profiles

  devise_for :users

  root :to => "home#index"

end

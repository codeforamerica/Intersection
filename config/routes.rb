Intersection::Application.routes.draw do
  resources :links

  resources :projects do 
    resources :links
  end

  resources :profiles

  devise_for :users

  root :to => "home#index"

end

Intersection::Application.routes.draw do
  resources :projects

  resources :profiles

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users

  root :to => "home#index"

end

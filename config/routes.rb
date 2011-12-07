Intersection::Application.routes.draw do
  resources :surveys
  resources :survey_responses
  match "/my_surveys", :controller => :survey_responses, :action => :index
  resources :teams

  resources :links

  resources :projects do 
    resources :links
  end

  resources :profiles

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users

  root :to => "home#index"

end

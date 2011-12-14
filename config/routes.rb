Intersection::Application.routes.draw do
  resources :events

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
  
  match "/projects/:project_name", :controller => :projects, :action => :show
  match "/teams/:team_name", :controller => :teams, :action => :show
  match "/profiles/:name", :controller => :profiles, :action => :show

  root :to => "home#index"

end

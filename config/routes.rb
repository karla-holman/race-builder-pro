RailsDevisePundit::Application.routes.draw do
  resources :pending_conditions

  get 'activities/index'

  resources :race_conditions

  resources :horse_conditions

  resources :horse_statuses

  resources :statuses

  resources :categories

  resources :conditions

  resources :horseraces

  resources :races

  resources :horses

  resources :activities

  post 'pending_conditions/:id' => 'pending_conditions#approve'

  get '/horses/:id/profile' => 'horses#profile'

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  
  resources :users do
  	resources :horses
  end

end
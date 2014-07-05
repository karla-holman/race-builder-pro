RailsDevisePundit::Application.routes.draw do
  resources :notifications

  get 'tels/friday' => 'tels#friday'
  get 'tels/saturday' => 'tels#saturday'
  get 'tels/sunday' => 'tels#sunday'
  
  get 'races/update_status' => 'races#update_status'
  get 'races/menu' => 'races#menu'
  get 'races/:id/racefinish' => 'races#racefinish'
  get 'races/menu/raceList' => 'races#raceList'
  get 'races/schedule' => 'races#schedule'
  get 'races/stakes' => 'races#stakes'
  post 'races/add_winner' => 'races#add_winner'
  post 'races/scratch_horse' => 'races#scratch_horse'

  post 'notifications/:id' => 'notifications#approve'

  get 'activities/index'

  resources :tels

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

  root :to => "home#index"
  
  devise_for :users, :controllers => {:registrations => "registrations"}
  
  resources :users do
  	resources :horses
  end

end
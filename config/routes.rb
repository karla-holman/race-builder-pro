RailsDevisePundit::Application.routes.draw do
  resources :race_distances

  resources :nomination_close_dates

  resources :horse_filter_settings

  resources :condition_nodes

  resources :claiming_prices

  resources :race_dates

  resources :tels

  resources :weeks

  resources :last_wins

  resources :horse_equipments

  resources :equipment

  resources :horse_meets

  resources :meets

  resources :notifications

  post 'tels/add_race' => 'tels#add_race'
  post 'tels/remove_race' => 'tels#remove_race'
  
  post 'horses/transferowner' => 'horses#ownerTransfer'
  post 'horses/transfertrainer' => 'horses#trainerTransfer'

  get 'races/update_status' => 'races#update_status'
  get 'races/menu' => 'races#menu'
  get 'races/:id/racefinish' => 'races#racefinish'
  get 'races/menu/raceList' => 'races#raceList'
  get 'races/menu/horseList' => 'races#horseList'
  get 'races/schedule' => 'races#schedule'
  get 'races/stakes' => 'races#stakes'
  get 'races/new/race_conditions' => 'races#new_with_condition_node'
  get 'races/:id/edit_with_race_conditions' => 'races#edit_with_condition_node'
  post 'races/add_winner' => 'races#add_winner'
  post 'races/scratch_horse' => 'races#scratch_horse'
  post 'races/:id/duplicate' => 'races#duplicate_race'
  post 'races/:id/resetHorseStatuses' => 'races#resetHorseStatuses'
  post 'races/:id/removeConfirmedHorses' => 'races#removeConfirmedHorses'

  post 'weeks/:id/reset_races' => 'weeks#reset_races'

  get 'meets/:id/deactivate_horses' => 'meets#deactivate_horses'
  get 'meets/:id/reset_races' => 'meets#reset_races'

  get 'users/new' => 'users#new'
  post 'users/createuser' => 'users#create'

  post 'notifications/:id' => 'notifications#approve'

  get 'activities/index'

  get '/horses/subregion_options' => 'horses#subregion_options'

  post 'condition_nodes/:id/addParentAND' => 'condition_nodes#addParentAND'
  post 'condition_nodes/:id/addParentOR' => 'condition_nodes#addParentOR'
  post 'condition_nodes/:id/addChildOperator' => 'condition_nodes#addChildOperator'
  post 'condition_nodes/:id/addCondition' => 'condition_nodes#addCondition'
  post 'condition_nodes/:id/removeNode' => 'condition_nodes#removeNode'

  post 'horseraces/confirm_horse' => 'horseraces#confirmHorse'


  resources :race_conditions

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
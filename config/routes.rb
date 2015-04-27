HCEF::Application.routes.draw do

  resources :after_schools
  match "/after_schools/update_by_id/:id" => "after_schools#update_by_id", via: :post
  match "/after_schools/update_sign_in_by_id/:id" => "after_schools#update_sign_in_by_id", via: :post
  match "/after_schools/load_data" => "after_schools#load_data", via: :post
  match "/master_view_new/submit" => "static#master_view_submit", via: :post
  get 'program/:id/:date' => "programs#show_day"

  resources :programs
  resources :locations
  resources :schools
  resources :children
  resources :guardians
  resources :instructors
  resources :sessions
  resources :sub_locations
  resources :enrichments
  resources :field_trips

  get 'home' => 'static#beta'
  get 'master_view' => 'static#home'
  get 'master_view_new' => 'static#master_view_new'
  get 'admin_dash' => 'static#admin_dash', :as => :dash
  root :to => 'static#beta'

  get 'create_child' => 'static#create_child'

  #User routes (login, logout, signup...)
  get 'user/edit' => 'users#edit', :as => :edit_current_user
  get 'signup' => 'users#new', :as => :signup
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout

  match '*post' => "errors#error_404", via: [:post, :get] 

end
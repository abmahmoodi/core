Rw::Core::Engine.routes.draw do
  get 'settings/setting_form'
  patch 'settings/save_setting'

  root to: 'dashboard#index'
  resources :users, only: [:new, :create, :edit, :update]

  get '/users/:id/activate' , to: 'users#activate', as: :activate_user


  get '/sign_up', to: 'users#new', as: :sign_up
  get 'secret_page', to: 'users#secret_page', as: :secret_page
  get 'user_list', to: 'users#user_list', as: :user_list
  get 'user_datatable', to: 'users#user_datatable', as: :user_datatable
  delete 'destroy_user', to: 'users#destroy_user', as: :destroy_user

  get 'new_user_form', to: 'users#new_user_form', as: :new_user_form
  post 'create_user', to: 'users#create_user', as: :create_user

  get 'edit_user_form', to: 'users#edit_user_form', as: :edit_user_form
  patch 'update_user', to: 'users#update_user', as: :update_user

  get '/user_type_form', to: 'users#user_type_form', as: :user_type_form
  patch '/assign_user_type', to: 'users#assign_user_type', as: :assign_user_type

  resources :sessions, only: [:new, :create, :destroy]
  get '/log_in', to: 'sessions#new', as: :log_in
  get '/log_out', to: 'sessions#destroy', as: :log_out

  resources :reset_passwords, only: [:new, :create, :update, :edit]

  resources :geo_locations
  get 'geo_location_datatable', to: 'geo_locations#geo_location_datatable', as: :geo_location_datatable
  delete 'destroy_geo', to: 'geo_locations#destroy_geo', as: :destroy_geo

  get 'agent_city', to: 'users#agent_city', as: :agent_city
  post 'create_agent_city', to: 'users#create_agent_city', as: :create_agent_city
  get 'agent_city_datatable', to: 'users#agent_city_datatable', as: :agent_city_datatable
  delete 'destroy_agent_city', to: 'users#destroy_agent_city', as: :destroy_agent_city

  get 'payments/pep_gateway', to: 'payments#pep_gateway', as: :pep_gateway
  post 'to_pep_gateway', to: 'payments#to_pep_gateway', as: :to_pep_gateway
  get 'pep_gateway_back', to: 'payments#pep_gateway_back', as: :pep_gateway_back
end

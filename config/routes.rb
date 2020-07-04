Rails.application.routes.draw do
  resources :cabs do
    collection do
      get :download
    end
  end

  # api routes
  get :cabs_list, to: 'cabs#cabs_list'
  get '/get_cab/:id', to: 'cabs#get_cab'

  devise_for :users, :controllers => { registrations: 'registrations'}

  devise_scope :user do
   get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root to: 'cabs#index'
end

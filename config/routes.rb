Rails.application.routes.draw do

  get 'pictures/new'
  get 'pictures/create'
  get 'pictures/destroy'
  devise_for :users
  root to: 'products#index'
    resources :products do
      resources :pictures, only: [:new, :create, :destroy]
      resources :sales, only: [:create, :destroy] do
        resources :reviews, only: [:create, :new, :destroy]
      end
    end
  resources :users, except: [:destroy, :create, :new]
  get 'dashboard', to: 'users#dashboard'
  resources :payments, only: [:new, :create]
  get 'payments/confirm', to: 'payments#confirm' #these are handled by devise
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

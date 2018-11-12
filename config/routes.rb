Rails.application.routes.draw do
  devise_for :users
  root to: 'products#index'
    resources :products do
      resources :sales, only: [:create, :destroy] do
        resources :review, only: [:create, :new, :destroy]
      end
    end
  resources :users, except: [:destroy, :create, :new]  #these are handled by devise
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

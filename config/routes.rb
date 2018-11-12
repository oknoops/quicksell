Rails.application.routes.draw do
  get 'sales/create'
  get 'sales/destroy'
  get 'reviews/create'
  get 'reviews/new'
  get 'reviews/destroy'
  get 'products/index'
  get 'products/show'
  get 'products/new'
  get 'products/create'
  get 'products/edit'
  get 'products/update'
  get 'products/destroy'
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  get 'users/update'
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

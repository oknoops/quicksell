Rails.application.routes.draw do

  get 'notifications/link_through'
  mount ActionCable.server => "/cable"
  get 'chat_rooms/show'
  get 'products/search', to: 'products#search'
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
  get 'payments/confirm', to: 'payments#confirm'
  get 'payments/retrieve', to: 'payments#retrieve'
  get 'payments/moneyback', to: 'payments#moneyback'
  resources :chat_rooms, only: [:index, :create, :show] do
    resources :messages, only: [:create]
  end
  get 'notifications/:id/link_through', to: 'notifications#link_through',
                                        as: :link_through
   #these are handled by devise
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

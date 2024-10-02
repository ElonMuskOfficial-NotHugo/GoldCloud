Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users

  resources :items do
    member do
      post 'add_to_cart'
      delete 'remove_from_cart'
    end
    collection do
      get 'search'
    end
  end

  resources :products do
    # post 'add_to_cart', on: :member
    # delete 'remove_from_cart', on: :member
  end

  resources :order_items, only: [:update]

  get 'cart', to: 'pages#cart'
  get 'checkout', to: 'pages#checkout'
  get 'account', to: 'pages#account', as: 'account'

  resources :orders do
    member do
      patch 'confirm_order'
    end
    collection do
      get 'pending_orders'
    end
  end

  get 'orders', to: 'orders#index'

  resources :chats, only: %i[index show create] do
    resources :messages, only: [:create]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users

  resources :items do
    collection do
      get 'search'
    end
  end

  resources :products, only: %i[new create edit update destroy]
  resources :packages, only: %i[new create edit update destroy]

  resources :order_items, only: %i[create update destroy]

  get 'cart', to: 'orders#cart'
  get 'checkout', to: 'orders#checkout'
  get 'account', to: 'pages#account', as: 'account'

  resources :orders do
    member do
      patch 'confirm_order'
      get 'order_confirmation'
    end
    collection do
      get 'pending_orders'
    end
  end

  get 'orders', to: 'orders#index'

  resources :chats, only: %i[index show create] do
    resources :messages, only: [:create]
  end

  resources :ratings, only: [:create, :update, :destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

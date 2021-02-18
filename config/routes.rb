Rails.application.routes.draw do
  # get 'products/index'
  # get 'products/new'
  # get 'products/edit'
  # get 'products/show'
  resources :categories
  resources :products
  # get 'home/index'
  devise_for :users, controllers: {
    :registrations => "users/registrations",
    :sessions => "users/sessions"
  }
  devise_scope :user do 
    post "/sessions/disable/:id" => "users/sessions#disable" 
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root to: "home#index"
  # root to: "dashboard#index"
  authenticated :user do
    root 'home#index', as: :authenticated_root
  end

  unauthenticated :user do
    root 'dashboard#index', as: :unauthenticated_root
  end

end

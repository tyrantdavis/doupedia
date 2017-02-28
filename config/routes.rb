Rails.application.routes.draw do

  devise_for :users
  resources :wikis
  resources :charges, only: [:new, :create]
  resources :downgrade, only: [:new, :create]
  resources :secret, only: [:index]

  authenticated :user do
    root 'secret#index', as: :authenticated_root
  end

  get 'secret/index'
  get 'downgrade/new'
  get 'welcome/index'
  get 'about' => 'welcome#about'
  root to: 'welcome#index'
end

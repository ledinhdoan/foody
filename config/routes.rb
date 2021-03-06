Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks#create"}
  resources :staticpages, only: :index
  root "staticpages#index"
  namespace :admin do
    root "admin/users#index"
    resources :users, :categories, :products, :suggests, :orders
  end
  resources :carts
  resources :products, only: [:index, :show] do
    resources :comments
  end
  resources :categories, only: [:index, :show]
  resources :suggests
  resources :contacts, only: :index
  resources :carts
  resources :orders
end

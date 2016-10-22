Rails.application.routes.draw do
  devise_for :users
  resources :staticpages, only: :index
  root "staticpages#index"
  namespace :admin do
    root "admin/users#index"
    resources :users, :categories, :products
  end
  resources :products, only: [:index, :show]
  resources :categories, only: :index
  resources :suggests
end

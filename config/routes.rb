Rails.application.routes.draw do
  resources :articles
  root 'home#index'
  post 'search', to: 'home#search'
end

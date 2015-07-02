Rails.application.routes.draw do
  resources :opinions
  resources :discussions
  root 'discussions#index'
end

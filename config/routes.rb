Rails.application.routes.draw do
  devise_for :users

  resources :opinions
  resources :discussions
  root 'discussions#land'
end

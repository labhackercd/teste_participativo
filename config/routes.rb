Rails.application.routes.draw do
  devise_for :users , :controllers => { :registrations => "users/registrations" }

  resources :opinions
  resources :discussions
  root 'discussions#land'
end

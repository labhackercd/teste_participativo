Rails.application.routes.draw do
  devise_for :users , :controllers => { :registrations => "users/registrations" }

  resources :discussions do
    resources :opinions do
      get :participation
    end
  end





  devise_scope :user do
    authenticated :user do
      root 'discussions#index', as: :authenticated_root
    end
    unauthenticated do
      root 'users/registrations#new', as: :unauthenticated_root
    end
  end
end

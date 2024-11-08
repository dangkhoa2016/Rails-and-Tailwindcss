Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  scope '/admin' do
    devise_for :users, skip: [:registrations], controllers: { sessions: 'users/sessions' }

    devise_scope :user do
      get 'users/sign_up', to: 'devise/registrations#new'
      post 'users/sign_up', to: 'devise/registrations#create'
      get 'profile/password', to: 'devise/registrations#edit'
      patch 'profile/password', to: 'devise/registrations#update'
      put 'profile/password', to: 'devise/registrations#update'
      delete 'profile', to: 'devise/registrations#destroy'
    end
  end

  namespace :admin do
    root to: 'dashboard#index'

    resources :profile, only: [] do
      collection do
        get '', to: 'profile#show'
        
        get 'avatar', to: 'profile#edit_avatar'
        patch 'avatar', to: 'profile#update_avatar'
        put 'avatar', to: 'profile#update_avatar'

        get 'edit', to: 'profile#edit'
        put '', to: 'profile#update'
        patch '', to: 'profile#update'
      end
    end

    resources :users, except: [:show] do
      member do
        get '', to: 'users#show', constraints: { id: /\d+/ }, as: :user
      end
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

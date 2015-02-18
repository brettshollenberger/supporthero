Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  devise_scope :user do
    get "login", to: "devise/sessions#new"
    get "logout", to: "devise/sessions#destroy"
  end

  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :users, :only => [:index, :show]
      resources :calendar_dates, :only => [:index, :show]
      resources :availabilities, :only => [:index, :show, :create, :destroy]
      resources :assignments, :only => [:index, :show, :create, :destroy, :update]
      resources :events, :only => [:index, :create, :destroy]
    end
  end
end

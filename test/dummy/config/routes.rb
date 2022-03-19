Rails.application.routes.draw do
  root "users#index"

  resources :users do
    resources :settings
  end

  resources :projects
end

Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :systems
  resources :sites
  resources :scans do
    collection do
      post :import_csv
      get 'list'
    end
  end
  root 'public#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

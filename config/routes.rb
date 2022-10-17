Rails.application.routes.draw do
  resources :sites
  resources :scans do
    collection do
      post :import_csv
    end
  end
  root 'public#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

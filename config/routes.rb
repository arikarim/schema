Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "schemas#index"
  resources :schemas do
    get '/finalized', to: 'schemas#finalized_schema'
  end
end

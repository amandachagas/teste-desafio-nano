Rails.application.routes.draw do
  root 'pages#index'

  namespace :api do
    namespace :v1 do      
      resources :deputies do
        collection do
          post :import_csv, defaults: { format: :json }
        end
      end

      resources :invoices
    end
  end

  get '*path', to: 'pages#index', via: :all
end

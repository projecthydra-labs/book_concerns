Rails.application.routes.draw do
  namespace :curation_concerns, path: :concern do
    resources :books, only: [] do
      member do
        get :manifest, defaults: { format: :json }
      end
    end
  end
end

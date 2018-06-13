Rails.application.routes.draw do
  namespace :v1 do
    namespace :public do
      resource :locations, only: [] do
        get '/:code', action: :country_locations
      end
      resource :target_groups, only: [] do
        get '/:code', action: :country_provider_groups
      end
    end
  end
  root controller: :pages, action: :root
end

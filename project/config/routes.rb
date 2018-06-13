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

    namespace :private do
      resource :locations, only: [] do
        get '/:code', action: :country_locations
      end
      resource :target_groups, only: [] do
        get '/:code', action: :country_provider_groups
      end

      post 'evaluate_target' => 'pricing#evaluate_target'
    end
  end

  resource :user, controller: 'user', only: [] do
    post :sign_in
    delete :sign_out
    post :sign_up
  end
  root controller: :pages, action: :root
end

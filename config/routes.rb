Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :jobs do
    collection do
      get :search
    end
    member do
      post :join
      post :quit
    end
    resources :resumes
  end

  namespace :account do
    resources :users
  end

  namespace :account do
    resources :jobs
  end

  namespace :admin do
    namespace :account do
      resources :jobs do
        member do
          post :publish
          post :hide
        end
        resources :resumes
      end
    end
    resources :jobs do
      member do
        post :publish
        post :hide
      end
      resources :resumes
    end
  end

  root 'welcome#index'
end

# typed: strict
# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: { sessions: 'sessions' }, path_names: { sign_in: 'login' }

    resource :user, only: %i[show update]
    scope 'profiles/:username' do
      get '/', to: 'profiles#show', as: :profile
      post '/follow', to: 'profiles#follow'
      delete '/follow', to: 'profiles#unfollow'
    end

    resources :tags, only: :index
    resources :articles, except: %i[new edit], param: :slug do
      get 'feed', on: :collection
      resources :comments, only: %i[create index destroy]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

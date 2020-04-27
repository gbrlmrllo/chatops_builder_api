# frozen_string_literal: true

Rails.application.routes.draw do
  Healthcheck.routes(self)

  devise_for :users,
             path: "",
             path_names: {
               sign_in: "login",
               sign_out: "logout",
               registration: "signup"
             },
             controllers: {
               sessions: "sessions",
               registrations: "registrations"
             }

  namespace :v1 do
    resources :users, only: :show
    resources :apps do
      get '/regenerate-token', action: 'regenerate_token', controller: 'credentials'
    end
  end
end

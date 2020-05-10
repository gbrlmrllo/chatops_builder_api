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

  scope :api do
    namespace :v1 do
      get "/me", to: "users#me"
      get "/consume-events", to: "events#consume"

      resources :apps do
        get "/regenerate-token", to: "credentials#regenerate_token"

        resources :event_schemas
      end
    end
  end
end

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
        post "procs/rebuild"
        post "procs/report"
        post "procs/restart"
        post "procs/scale"
        post "procs/start"
        post "procs/stop"

        get "logs/show", param: :app_name

        post "domains/add"
        post "domains/remove"

        post "configs/set"
        post "configs/unset"

        post "apps/create"
        post "apps/destroy"
        post "apps/rename"
        post "apps/urls"
        post "apps/deploy"
    end
  end

  root to: "home#index"
end

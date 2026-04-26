Rails.application.routes.draw do
  root "home#index"

  # Public pages
  resources :posts, only: [ :index, :show ]
  get "/news", to: "posts#index", as: :news

  get "/volunteer", to: "home#volunteer", as: :volunteer
  post "/volunteer", to: "home#create_volunteer_submission", as: :volunteer_submissions
  get "/about", to: "home#about", as: :about
  get "/issues", to: "home#issues", as: :issues
  get "/issues/:id", to: "home#show_issue", as: :issue
  get "/events", to: "home#events", as: :events

  namespace :admin do
    resources :issues
    root "dashboard#index"
    resources :posts
    resources :news_articles
    resources :news_feeds, only: [ :index, :create, :destroy ]
    resources :volunteer_interests
    resources :volunteer_submissions do
      member do
        patch :mark_welcome_sent
      end
    end
  end

  # Public volunteer submission
  resources :volunteer_submissions, only: [ :create ]
  resources :volunteer_interests, only: []
  # Error pages
  match "/404", to: "errors#not_found",             via: :all
  match "/422", to: "errors#unprocessable_entity",  via: :all
  match "/500", to: "errors#internal_server_error", via: :all
  resource :session
  resources :passwords, param: :token
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end

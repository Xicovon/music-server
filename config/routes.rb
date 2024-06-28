Rails.application.routes.draw do
  get "job/index"
  get "job/start_retrieve_song_urls_job", to: 'job#startRetrieveSongUrlsJob'
  get "download_queue/index"
  get "song/index"
  get "song/show"
  get "song/edit"
  get "song/delete"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  #root "/"

  # oauth2
  get '/oauth2callback', to: 'oauth#oauth_callback'
  get '/authorize', to: 'oauth#authorize'
end

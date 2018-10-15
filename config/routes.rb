require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  constraints(host: /^www\./i) do
    match '(*any)' => redirect { |params, request|
      URI.parse(request.url).tap { |uri| uri.host.sub!(/^www\./i, '') }.to_s
    }, via: :get
  end

  authenticate :user, lambda { |u| u.id == 1 } do
    mount Sidekiq::Web, at: '/sidekiq', as: :sidekiq
  end

  namespace :pages do
    get "allpodcasts"
    get "locations"
    get "platforms"
    get "timeofday"
    get "downloads"
  end

  resources :episodes
  get 'pending' => 'episodes#pending', as: :pending
  resources :podcasts
  get 'search' => 'search#search'
  get 'shows/acp' => redirect('/podcasts/acp')
  get 'shows/boomaddiction' => redirect('/podcasts/ba')
  get 'shows/cbw' => redirect('/podcasts/cbw')
  get 'shows/collectingvaliant' => redirect('/podcasts/cv')
  get 'shows/iamgotham' => redirect('/podcasts/iag')
  get 'shows/nerdylegion' => redirect('/podcasts/nl')
  get 'shows/pth' => redirect('/podcasts/pth')
  get 'shows/rb' => redirect('/podcasts/rb')
  get 'podcasts/rb' => redirect('/podcasts/absolutedc')
  get 'podcasts/pth' => redirect('/podcasts/wrestlinginsomniac')
  get 'shows/marvelpodcast' => redirect('/podcasts/ump')
  get 'shows/vcp' => redirect('/podcasts/vcp')
  get 'shows/whatdidyouwatchthisweek' => redirect('/podcasts/wdyw')
  # devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callback" }, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup'}
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup'}
  root :to => 'episodes#index'
  get 'privacy' => 'pages#privacy', as: :privacy
  get 'terms' => 'pages#terms', as: :terms
  get 'subscribe' => 'pages#subscribe', as: :subscribe
  get 'user_admin' => 'pages#user_admin', as: :user_admin
  resource :pages do
    member do
      post :create_user
      post :destroy_user
      post :podcaster_true
      post :podcaster_false
      post :analytics_true
      post :analytics_false
      post :admin_true
      post :admin_false
    end
  end
  get 'analytics' => 'pages#analytics', as: :analytics
  get 'sitemap.xml', :to => 'pages#sitemap', :defaults => { :format => 'xml' }
  get 'robots.:format' => 'pages#robots'
  get 'digitalocean' => 'pages#digitalocean'
  get 'audible' => 'pages#audible'
  get '*path' => redirect('/')
end

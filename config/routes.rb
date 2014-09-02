Mediadrawer::Rails::Engine.routes.draw do
  root to: 'application#index'
  scope :api, defaults: {format: :json} do
    resources :media
  end
  resources :folders, only: [:show]
end

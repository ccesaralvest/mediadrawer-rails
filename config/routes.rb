Mediadrawer::Rails::Engine.routes.draw do
  root to: 'application#index'
  scope :api, defaults: {format: :json} do
    resources :media, only: [:index, :show, :create, :update]
    resources :folders, only: [:index, :create, :update]
  end
end

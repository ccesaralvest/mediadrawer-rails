Mediadrawer::Rails::Engine.routes.draw do
  scope :api, defaults: {format: :json} do
    root to: 'application#index', :defaults => { :format => 'html' }
    resources :media, only: [:index, :show, :create, :update]
    resources :folders, only: [:index, :create, :update]
  end
end

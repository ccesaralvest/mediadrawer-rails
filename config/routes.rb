Mediadrawer::Rails::Engine.routes.draw do
  root to: 'application#index'
  resource :media
end
Rails.application.routes.draw do
  mount Mediadrawer::Rails::Engine => "/mediadrawer"
  root :to=>'application#index'
end

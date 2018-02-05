Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  resources :tweets do
    resources :replies, only: [:create]
  end
  root "tweets#index"

  # 管理者
  namespace :admin do
    resources :tweets
    root "tweets#index"
  end
  
end

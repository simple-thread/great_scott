Rails.application.routes.draw do
  devise_for :admins
  root to: redirect('/posts')
  resources :posts
end

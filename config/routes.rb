Rails.application.routes.draw do
  root to: redirect('/posts')
  resources :posts
end

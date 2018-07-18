Rails.application.routes.draw do
  get 'users/index'

  get 'pages/home'

  devise_for :users
  mount Ckeditor::Engine => '/ckeditor'
  root 'pages#home'

  resources :users
  resources :posts
  resources :categories

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

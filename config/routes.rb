Rails.application.routes.draw do
  root 'static_pages#top'
  resources :users
  resources :quizzes do
    get 'result', to: 'quizzes#result'
    get 'likes', to: 'quizzes#likes', on: :collection
    get 'my', to: 'quizzes#my', on: :collection
  end
  resources :likes, only: %i[create destroy]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  post 'quizzes/upload_photo', to: 'quizzes#upload_photo'
  get 'terms_of_service', to: 'static_pages#terms_of_service'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'contact', to: 'static_pages#contact'
  post "oauth/callback", to: "oauth#callback"
  get "oauth/callback", to: "oauth#callback"
  get "oauth/:provider", to: "oauth#oauth", as: :auth_at_provider

  namespace :admin do
    resources :users
    resources :quizzes
  end
end

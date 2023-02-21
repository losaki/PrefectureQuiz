Rails.application.routes.draw do
  root 'static_pages#top'
  resources :users
  resources :quizzes do
    get 'result', to: 'quizzes#result'
  end
  resources :likes, only: %i[create destroy]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  post 'quizzes/upload_photo', to: 'quizzes#upload_photo'
  get 'terms_of_service', to: 'static_pages#terms_of_service'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'contact', to: 'static_pages#contact'
end

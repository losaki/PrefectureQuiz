Rails.application.routes.draw do
  root 'static_pages#top'
  resources :users
  resources :quizzes do
    get 'result', to: 'quizzes#result'
  end
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  post 'quizzes/upload_photo', to: 'quizzes#upload_photo'
end

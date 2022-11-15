Rails.application.routes.draw do
  root 'static_pages#top'
  resources :users
  resources :quizzes do
    get 'result', to: 'quiz#result'
  end
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end

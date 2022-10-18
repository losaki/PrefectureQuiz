Rails.application.routes.draw do
  get 'played_quizzes/create'
  get 'played_quizzes/destroy'
  get 'likes/create'
  get 'likes/destroy'
  get 'quizzes/new'
  get 'quizzes/create'
  get 'quizzes/edit'
  get 'quizzes/destroy'
  get 'user_sessions/new'
  get 'user_sessions/create'
  get 'user_sessions/destroy'
  get 'users/new'
  get 'users/create'
  get 'users/edit'
  get 'users/destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

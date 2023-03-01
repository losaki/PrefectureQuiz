class LikesController < ApplicationController
  def create
    quiz = Quiz.find(params[:quiz_id])
    current_user.like(quiz)
    render turbo_stream: turbo_stream.replace(
      'like-button', partial: 'quizzes/like_button', locals: { quiz: quiz }
    )
  end

  def destroy
    quiz = current_user.likes.find_by(quiz_id: params[:id]).quiz
    current_user.unlike(quiz)
    render turbo_stream: turbo_stream.replace(
      'like-button', partial: 'quizzes/like_button', locals: { quiz: quiz }
    )
  end
end

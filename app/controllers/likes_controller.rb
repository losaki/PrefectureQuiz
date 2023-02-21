class LikesController < ApplicationController
  def create
    quiz = Quiz.find(params[:quiz_id])
    current_user.like(quiz)
    redirect_back fallback_location: root_path
  end

  def destroy
    quiz = current_user.likes.find_by(quiz_id: params[:id]).quiz
    current_user.unlike(quiz)
    redirect_back fallback_location: root_path
  end
end

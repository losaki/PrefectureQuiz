class Admin::QuizzesController < Admin::BaseController
  before_action :set_quiz, only: %i[show edit destroy update]
  def index
    @quizzes = Quiz.all
  end

  def show; end

  def edit; end

  def destroy
    @quiz.destroy!
    redirect_to admin_quizzes_path, success: "クイズを削除しました"
  end

  def update
    if @quiz.update(quiz_params)
      redirect_to admin_quizzes_path, success: "クイズを更新しました"
    else
      flash.now[:notice] = "クイズの更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def quiz_params
    params.require(:quiz).permit(:photo, :prefecture_id, :hint, :description, :play_count, :correct_count, choices_attributes: [:id, :prefecture_id])
  end

  def set_quiz
    @quiz = Quiz.find(params[:id])
  end
end

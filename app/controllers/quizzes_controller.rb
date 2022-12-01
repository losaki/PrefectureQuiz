class QuizzesController < ApplicationController
  before_action :set_quiz, only: %i[edit destroy update]
  def index
    @quizzes = Quiz.all.includes(:user).order(created_at: :desc)
  end

  def new
    @quiz = Quiz.new
    3.times { @quiz.choices.build }
  end

  def create
    @quiz = current_user.quizzes.build(quiz_params)
    if @quiz.save == true
      @quiz.choices.build(prefecture_id: @quiz.prefecture_id)
      @quiz.save
      redirect_to quizzes_path, success: "クイズを作成しました"
    else
      flash.now[:notice] = "クイズの作成に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @quiz = Quiz.find(params[:id])
  end

  def edit; end

  def destroy
    @quiz.destroy!
    redirect_to quizzes_path, success: "クイズを削除しました"
  end

  def update
    if @quiz.update(quiz_params)
      redirect_to quiz_path, success: "クイズを更新しました"
    else
      flash.now[:notice] = "クイズの更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end


  def result
    @quiz = Quiz.find(params[:quiz_id])
  end

  private

  def quiz_params
    params.require(:quiz).permit(:prefecture_id, :photo, :hint, :description, choices_attributes: [:id, :prefecture_id])
  end

  def set_quiz
    @quiz = current_user.quizzes.find(params[:id])
  end
end

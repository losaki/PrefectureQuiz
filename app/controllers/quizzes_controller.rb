class QuizzesController < ApplicationController
  def index
    @quizzes = Quiz.all.includes(:user).order(created_at: :desc)
  end

  def new
    @quiz = Quiz.new
    3.times { @quiz.choices.build }
  end

  def create
    @quiz = current_user.quizzes.build(quiz_params)
    @quiz.choices.build(prefecture_id: @quiz.prefecture_id)
    if @quiz.save
      redirect_to quizzes_path
    else
      render :new
    end
  end

  def show
    @quiz = Quiz.find(params[:id])
  end

  def edit
  end

  def destroy
    @quiz.destroy!
    redirect_to quizzes_path
  end

  def update
    if @quiz.update(quiz_params)
      redirect_to quiz_path
    else
      render :edit
    end
  end


  def result
    @quiz = Quiz.find(params[:quiz_id])
  end

  private

  def quiz_params
    params.require(:quiz).permit(:prefecture_id, :photo, :hint, :description, choices_attributes: [:id, :prefecture_id])
  end

end

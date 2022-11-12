class QuizzesController < ApplicationController
  def index
    @quizzes = Quiz.all.includes(:user).order(created_at: :desc)
  end

  def new
    @quiz = Quiz.new
    4.times { @quiz.choices.build }
  end

  def create
    @quiz = current_user.quizzes.build(quiz_params)
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
  end

  private

  def quiz_params
    params.require(:quiz).permit(:prefecture_id, :photo, :hint, :description, choices_attributes: [:id, :name])
  end

end

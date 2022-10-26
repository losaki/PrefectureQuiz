class QuizzesController < ApplicationController
  def index
    @quizzes = Quiz.all.includes(:user).order(created_at: :desc)
  end

  def new
  end

  def create
  end

  def edit
  end

  def destroy
  end
end

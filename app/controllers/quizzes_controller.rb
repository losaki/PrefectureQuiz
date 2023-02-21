class QuizzesController < ApplicationController
  before_action :set_quiz, only: %i[edit destroy update]
  def index
    @q = Quiz.ransack(params[:q])
    @q.sorts = 'id desc' if @q.sorts.empty?
    @quizzes = @q.result(distinct: true).includes(:user).page(params[:page])
  end

  def new
    if logged_in?
      @quiz = Quiz.new
      3.times { @quiz.choices.build }
    else
      redirect_to quizzes_path
      flash[:notice] = "クイズを作成するにはログインが必要です"
    end
  end

  def create
    @quiz = current_user.quizzes.build(quiz_params)
    @quiz.photo.attach(params[:quiz][:photo])
    create_random_choices
    if @quiz.save == true
      respond_to do |format|
        @quiz.choices.build(prefecture_id: @quiz.prefecture_id)
        @quiz.save
        format.turbo_stream { flash.now[:success] = "クイズを作成しました" }
        format.html { redirect_to quizzes_path, success: "クイズを作成しました" }
      end
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
    params.require(:quiz).permit(:photo, :prefecture_id, :hint, :description, choices_attributes: [:id, :prefecture_id])
  end

  def set_quiz
    @quiz = current_user.quizzes.find(params[:id])
  end

  def create_random_choices #選択肢をランダムに生成
    if params[:create_random_choices] == "true"
      prefecture_ids = (1..47).to_a
      prefecture_ids.delete(@quiz.prefecture_id)
      @quiz.choices.each do |choice|
        choice.prefecture_id = prefecture_ids.sample
      end
    end
  end
end

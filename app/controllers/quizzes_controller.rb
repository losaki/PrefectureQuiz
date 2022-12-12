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

  def upload_photo
    @photo_blob = create_blob(params[:photo])
    render json: @photo_blob
  end

  private

  def quiz_params
    params.require(:quiz).permit(:prefecture_id, :hint, :description, choices_attributes: [:id, :prefecture_id]).merge(photo: uploaded_photo)
  end

  def set_quiz
    @quiz = current_user.quizzes.find(params[:id])
  end

  def uploaded_photo
      ActiveStorage::Blob.find(params[:quiz][:photo][0].to_i)
  end

  def create_blob(file)
    ActiveStorage::Blob.create_and_upload!(
      io: file.open,
      filename: file.original_filename,
      content_type: file.content_type
    )
  end

end

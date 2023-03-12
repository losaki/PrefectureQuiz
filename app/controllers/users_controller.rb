class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit destroy update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to quizzes_path, success: 'ユーザー登録が完了しました'
    else
      flash.now[:notice] = 'ユーザー登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit
    render turbo_stream: turbo_stream.replace(
      'user_quizzes', partial: 'form'
    )
  end

  def destroy
    @user.destroy!
    redirect_to root_path, success: 'ユーザー情報を削除しました'
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, success: 'ユーザー情報を更新しました'
    else
      flash.now[:notice] = 'ユーザー情報の更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end

  def set_user
    @user = current_user
  end
end

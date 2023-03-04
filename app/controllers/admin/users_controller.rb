class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[edit destroy update]

  def index
    @users = User.all
  end

  def edit; end

  def destroy
    @user.destroy!
    redirect_to admin_users_path, success: 'ユーザーを削除しました'
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, success: 'ユーザーを更新しました'
    else
      flash.now[:notice] = 'ユーザーの更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end

  def set_user
    @user = User.find(params[:id])
  end
end

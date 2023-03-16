class UserSessionsController < ApplicationController
  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to quizzes_path, flash[:success] = { success: 'ログインしました' }
    else
      flash.now[:notice] = 'ログインに失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    respond_to do |format|
      format.html { redirect_to root_path, status: :see_other }
    end
    flash[:success] = 'ログアウトしました'
  end
end

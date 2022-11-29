class UserSessionsController < ApplicationController
  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to root_path, flash = {success: "ログインしました"}
    else
      render :new
    end
  end

  def destroy
    logout
    respond_to do |format|
      format.html { redirect_to root_path, status: :see_other }
    end
  end
end

class Admin::BaseController < ApplicationController
  before_action :check_admin

  private

  def check_admin
    redirect_to root_path, error: "権限がありません" unless current_user.role == 1
  end
end

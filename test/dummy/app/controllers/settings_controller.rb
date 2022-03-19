class SettingsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @user.settings.create!(setting_params)
    redirect_to user_path(@user)
  end

  private

  def setting_params
    params.require(:setting).permit(:name, :value)
  end
end

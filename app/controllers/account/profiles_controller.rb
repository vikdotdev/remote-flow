class Account::ProfilesController < Account::AccountController
  def edit; end

  def update
    respond_to do |format|
      if current_user.update_with_password(user_params)
        format.html { redirect_to edit_account_profile_path, notice: 'You have successfully updated' }
      else
        format.html { redirect_to edit_account_profile_path, error: current_user.errors.full_messages }
      end
    end
  end

  private

  def user_params
    if params[:user][:password].blank?
      params.require(:user).permit(:email, :first_name, :last_name, :current_password)
    else
      params.require(:user).permit(:email, :first_name, :last_name, :current_password, :password, :password_confirmation)
    end
  end
end

class Account::ProfilesController < Account::AccountController
  def edit; end

  def update
    if current_user.update_with_password(user_params)
      flash[:success] = 'You have successfully updated'
      redirect_to edit_account_profile_path
    else
      flash[:danger] = current_user.errors.full_messaages
      render :edit
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

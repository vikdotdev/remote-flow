class Account::ProfilesController < Account::AccountController
  def edit; end

  def update
    if current_user.update(user_params)
      flash[:success] = 'You have successfully updated'
      redirect_to edit_account_profile_path
    else
      flash[:error] = "#{current_user.errors.full_messages}"
      render :edit
    end
  end

  def update_password
    if current_user.update_with_password(user_password_params)
      bypass_sign_in(current_user)
      flash[:success] = 'You have successfully updated password'
      redirect_to edit_account_profile_path
    else
      flash[:error] = "#{current_user.errors.full_messages}"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :avatar)
  end

  def user_password_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end
end

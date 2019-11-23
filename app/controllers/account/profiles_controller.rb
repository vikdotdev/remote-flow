class Account::ProfilesController < Account::AccountController
  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to edit_account_profile_path, notice: 'You have successfully updated' }
        format.xml  { head :ok }
      else
        format.html { redirect_to edit_account_profile_path, error: @user.errors.full_messages }
      end
    end
  end

  private

  def user_params
    if params[:user][:password].blank?
      params.require(:user).permit(:email, :first_name, :last_name)
    else
      params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
    end
  end

end

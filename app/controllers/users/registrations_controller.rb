class Users::RegistrationsController < Devise::RegistrationsController
  def new
    @token = params[:invite_token]
    super
  end

  def create
    @token = params[:user][:invite_token]

    if @token.nil?
      super
    else
      @user = User.new(sign_up_params)
      invite = Invite.find_by_token(@token)
      @user.organization = invite.organization
      @user.email = invite.email
      @user.role = invite.role

      if @user.save
        invite.destroy
        bypass_sign_in @user
        flash[:success] = 'User successfully created.'
        redirect_to account_user_path(@user)
      else
        flash[:danger] = 'Failed to create user.'
        render action: :new, params: { invite_token: @token }
      end
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(
      :email,
      :first_name,
      :last_name,
      :password,
      :password_confirmation,
      organization_attributes: [:name]
    )
  end

  def account_update_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :current_password,
      organization_attributes: %i[id name]
    )
  end
end

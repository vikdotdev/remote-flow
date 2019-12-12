class Users::RegistrationsController < Devise::RegistrationsController
  def new
    @token = params[:invite_token]
    super
  end

  def create
    @token = params[:user][:invite_token]

    if @token.nil?
      build_resource(sign_up_params)

      resource.role = User::ADMIN

      resource.save
      yield resource if block_given?

      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
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

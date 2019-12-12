class RegistrationsController < ApplicationController
  layout 'devise'
  # before_action :require_admin_or_super_admin_only, only: %i[new]

  def new
    @token = params[:invite_token]
    @user = User.new
    @user.organization = Organization.new
  end

  def create
    @user = User.new(sign_up_params)
    @user.role = User::ADMIN

    if @user.organization.save
      @user.organization_id = @user.organization.id
      if @user.save
        bypass_sign_in @user
        flash[:success] = 'Success! Welcome.'
        redirect_to account_users_path
      end
    end

    unless @user.valid?
      flash[:success] = 'Error signing up.'
      render :new
    end
  end

  def accept
    @token = params[:user][:invite_token]

    return if @token.nil?

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
end

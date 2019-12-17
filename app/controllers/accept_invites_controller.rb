class AcceptInvitesController < ApplicationController
  layout 'devise'

  def new
    @token = params[:invite_token]
    @user = User.new
  end

  def create
    @token = params[:user][:invite_token]

    @user = User.new(accept_params)
    invite = Invite.find_by!(token: @token)
    @user.organization = invite.organization
    @user.email = invite.email
    @user.role = invite.role

    if @user.save
      invite.destroy
      bypass_sign_in @user
      flash[:success] = 'User successfully created.'
      redirect_to account_path
    else
      flash[:danger] = 'Failed to create user.'
      render action: :new, params: { invite_token: @token }
    end
  end

  private

  def accept_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :password,
      :password_confirmation
    )
  end
end


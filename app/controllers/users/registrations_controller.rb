class Users::RegistrationsController < Devise::RegistrationsController
  layout 'sign_up'

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 organization_attributes: [:name])
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password,
                                 organization_attributes: %i[id name])
  end
end

# frozen_string_literal: true

# good
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: %i[new create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def  new
  #   # @organization = Organization.create(name: params[:user][:organization][:name])
  #   # @organization << User.create(email: params[:user][:email], password: params[:user][:password])
  #   super
  # end

  # POST /resource
  def create
    @organization = Organization.new(name: params[:user][:organization_name])

    if @organization.save
      @user = User.new(email: params[:user][:email], password: params[:user][:password],
                       organization_id: @organization.id)
      if @user.save
        flash[:alert] = 'Ви успішно зареєстровані'
        redirect_to :root
      end
    else
      flash[:notice] = 'Щось пішло не так'
      redirect_to :root
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:organization])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end

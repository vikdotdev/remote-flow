require 'slack-notifier'

class Users::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)

    debugger
    resource.role = User::ADMIN
    resource.organization_id = resource.organization.id if resource.organization.save
    resource.first_name = 'test_first_name'
    resource.last_name = 'test_last_name'

    resource.save
    yield resource if block_given?

    if resource.persisted?
      notifier = Slack::Notifier.new(
        "https://hooks.slack.com/services/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",
        channel: "#reflow",
        username: "notifier"
      )

      notifier.ping "Organization #{resource.organization.name} was just created!"

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
      debugger
      resource.organization.delete
      resource.delete

      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

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

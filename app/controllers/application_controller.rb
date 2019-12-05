class ApplicationController < ActionController::Base
  layout :layout_by_resource

  private

  def layout_by_resource
    if devise_controller?
      'devise'
    else
      'application'
    end
  end

  def require_super_admin_only!
    unless current_user.super_admin?
      flash[:warning] = "You are not allowed to do such things!"
      redirect_to controller: 'dashboard', action: 'index'
    end
  end
end

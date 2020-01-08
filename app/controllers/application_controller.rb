class ApplicationController < ActionController::Base
  layout :layout_by_resource
  impersonates :user
  before_action :set_raven_context

  private

  def layout_by_resource
    if devise_controller?
      'devise'
    else
      'application'
    end
  end

  def require_super_admin_only!
    return if current_user.super_admin?

    flash[:warning] = 'You don\'t have permission to perform such action!'
    redirect_to controller: 'dashboard', action: 'index'
  end

  def require_admin_only!
    return if current_user.admin?

    flash[:warning] = 'You don\'t have permission to perform such action!'
    redirect_to controller: 'dashboard', action: 'index'
  end

  def require_admin_or_super_admin_only
    return if current_user.super_admin? || current_user.admin?

    flash[:warning] = 'You don\'t have permission to perform such action!'
    redirect_to controller: 'dashboard', action: 'index'
  end

  def set_raven_context
    Raven.user_context(id: session[:current_user_id])
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end

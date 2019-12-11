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

  def have_access_to_page
    if params[:id].to_i != current_user.id
      flash[:warning] = 'You don\'t have permission to perform such action!'
      redirect_to controller: 'dashboard', action: 'index'
    end
  end
end

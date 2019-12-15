class Account::DashboardController < Account::AccountController
  def index
  end

  def analytics
    require_super_admin_only!
  end
end

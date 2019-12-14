class Account::DashboardController < Account::AccountController
  def index
  end

  def analitics
    require_super_admin_only!
  end
end

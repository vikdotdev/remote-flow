class Account::DashboardController < Account::AccountController
  before_action :require_super_admin_only!, only: [:analytics]

  def index
    notification
  end

  def analytics
  end
end

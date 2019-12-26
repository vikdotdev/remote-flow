class Account::DashboardController < Account::AccountController
  before_action :require_super_admin_only!, only: [:analytics]

  def index
  end

  def analytics
  end
end

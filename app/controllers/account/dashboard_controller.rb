class Account::DashboardController < Account::AccountController
  before_action :require_super_admin_only!, only: [:analytics, :feedbacks]

  def index
    @data = Dashboard.new(current_user).data
  end

  def analytics
  end
end

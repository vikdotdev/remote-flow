class Account::DashboardController < Account::AccountController
  before_action :require_super_admin_only!, only: [:analytics, :feedbacks]

  def index
    @data = Dashboard.new(current_user).data
  end

  def analytics
  end

  def feedbacks
    @feedbacks = Feedback.by_creation_date
  end
end

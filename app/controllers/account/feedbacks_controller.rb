class Account::FeedbacksController < Account::AccountController
  before_action :require_super_admin_only!

  def index
    @feedbacks = Feedback.by_creation_date.all
  end
end

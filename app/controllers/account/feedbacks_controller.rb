class Account::FeedbacksController < Account::AccountController
  before_action :require_super_admin_only!, only: [:index, :destroy]

  def index
    @feedbacks = Feedback.by_creation_date
  end

  def destroy
    @feedback = Feedback.find(params[:id])
    if @feedback.destroy
      flash[:success] = 'Feedback successfully deleted.'
    else
      flash[:danger] = 'Failed to delete feedback.'
    end
    redirect_to account_feedbacks_path
  end
end

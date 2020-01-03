class Account::FeedbacksController < Account::AccountController
  before_action :require_super_admin_only!, only: [:index, :destroy]

  def index
    @feedbacks = Feedback.with_deleted.by_creation_date
  end

  def destroy
    @feedback = Feedback.with_deleted.find(params[:id])
    if @feedback.deleted_at == nil
      @feedback.destroy
      flash[:info] = 'Feedback was put on delete queue'
    else
      @feedback.really_destroy!
      flash[:success] = 'Feedback successfully deleted.'
    end
    redirect_to account_feedbacks_path
  end

  def restore
    @feedback = Feedback.with_deleted.find(params[:id])
    @feedback.restore
    flash[:success] = 'Feedback successfully restored.'

    redirect_to account_feedbacks_path
  end
end

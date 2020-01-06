class FeedbacksController < ApplicationController
  layout 'public'

  def new
    set_meta_tags title: 'Contact us'
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      flash[:success] = 'The message was successfully sent. We will contact you shortly.'
      redirect_to root_path
    else
      flash[:danger] = 'An error occurred, please try again later'
      render :new
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:email, :name, :message)
  end
end

class PublicController < ApplicationController
  layout 'public'

  def index
    set_meta_tags title: 'Public page'
  end

  def pricing
    set_meta_tags title: 'Pricing'
  end

  def about_us
    set_meta_tags title: 'About us'
  end

  def contact_us
    set_meta_tags title: 'Contact us'
    @feedback = Feedback.new
  end

  def feedback
    @feedback = Feedback.new(feedback_params)
    if  @feedback.save
      flash[:success] = 'The message was successfully sent. We will contact you shortly.'
      redirect_to contact_us_path
    else
      flash[:danger] = 'An error occurred, please try again later'
      render :contact_us
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:email, :name, :message)
  end
end
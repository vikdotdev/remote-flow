class Account::NotificationController < Account::AccountController
  def create
    @notification = Notification.new(notification_params)
    @notification.save
  end

  def mark_as_read
    @notification = resource
    @notification.update_attributes(read: true)

    respond_to do |format|
      format.html { redirect_to '/account' }
    end
  end

  def mark_all_as_read
    collection.update_all(read: true)

    respond_to do |format|
      format.html { redirect_to '/account' }
    end
  end

  private

  def notification_params
    params.require(:notification).permit(:body, :read, :notificable_type)
  end

  def collection
    current_user.notifications
  end

  def resource
    collection.find(params[:id])
  end
end

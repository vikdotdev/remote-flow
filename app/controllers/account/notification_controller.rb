class Account::NotificationController < Account::AccountController
  def show
    @notifications = current_user.notifications
    @read_notifications = current_user.notifications.where(read: true)
    @unread_notificaitons = current_user.notifications.where(read: false)
  end

  def create
    @notification = Notification.new(notification_params)
    @notification.save
  end

  def mark_s_read
    @notification = resource
    @notification.read = true
  end

  def mark_all_as_read
    collection.each do |notification|
      notification.read = true
    end
  end

  private

def notification_params
    params.require(:notification).permit(:body, :read)
  end

  def collection
    current_user.notifications
  end

  def resource
    collection.find(params[:id])
  end
end

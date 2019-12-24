class Account::NotificationController < Account::AccountController

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
end

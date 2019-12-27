class Account::NotificationsController < Account::AccountController
  def mark_all_as_read
    collection.update_all(read: true)

    redirect_back(fallback_location: account_path)
  end

  private

  def collection
    current_user.notifications
  end
end

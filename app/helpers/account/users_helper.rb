module Account::UsersHelper
  def has_access_to_edit_super_admin?(user = @user)
    !(!current_user.super_admin? && user.super_admin?)
  end
end

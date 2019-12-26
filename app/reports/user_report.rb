class UserReport < BaseReport
  def role_distribution
    {
      admin: {
        role: User::ADMIN.capitalize,
        count: collection.where(role: User::ADMIN).count
      },
      manager: {
        role: User::MANAGER.capitalize,
        count: collection.where(role: User::MANAGER).count
      }
    }
  end
end


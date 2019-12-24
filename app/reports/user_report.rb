class Report::User < Report::BaseReport
  def role_distribution
    {
      admins: {
        role: ::User::ADMIN.capitalize,
        count: collection.where(role: ::User::ADMIN).count,
      },
      managers: {
        role: ::User::MANAGER.capitalize,
        count: collection.where(role: ::User::MANAGER).count
      }
    }
  end
end


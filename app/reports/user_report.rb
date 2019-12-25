class UserReport < BaseReport
  def role_distribution
    collection.group(:role).count
  end
end


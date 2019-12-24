require 'base_report'

class Dashboard
  attr_reader :user, :organization

  def initialize(user)
    @user = user
  end

  def data
    result = Hash.new

    if user.super_admin?
      result[:organization_count] = OrganizationReport.new(@user).count
      result[:organization_trends] = OrganizationReport.new(@user).trends
    else
      result[:user_trends] = UserReport.new(@user).trends
    end

    user_report = UserReport.new(@user)
    content_report = ContentReport.new(@user)

    result[:channel_count] = ChannelReport.new(@user).count
    result[:invite_count] = InviteReport.new(@user).count
    result[:user_count] = user_report.count
    result[:role_distribution] = user_report.role_distribution
    result[:file_count] = content_report.file_count
    result[:content_type_distribution] = content_report.type_distribution

    result
  end
end


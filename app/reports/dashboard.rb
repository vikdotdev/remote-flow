class Dashboard
  attr_reader :user, :organization

  def initialize(user)
    @user = user
  end

  def data
    result = {}

    user_report = UserReport.new(@user)
    content_report = ContentReport.new(@user)

    if user.super_admin?
      organization_report = OrganizationReport.new(@user)
      result[:organization_count] = organization_report.count
      result[:organization_trends] = organization_report.trends
    else
      result[:user_trends] = user_report.trends
    end

    result[:channel_count] = ChannelReport.new(@user).count
    result[:invite_count] = InviteReport.new(@user).count
    result[:user_count] = user_report.count
    result[:role_distribution] = user_report.role_distribution
    result[:file_count] = content_report.file_count
    result[:content_type_distribution] = content_report.type_distribution
    result[:content_versions] = content_versions

    result
  end

  private

  def content_versions
    versions_array = PaperTrail::Version.where("object LIKE ? ",
      "%organization_id: " + @user.organization_id.to_s + '%').order(created_at: :desc).first(10)

    versions_array
  end
end

class Dashboard
  attr_reader :user, :organization

  def initialize(user)
    @user = user
  end

  def data
    data = Hash.new

    if user.super_admin?
      data[:organizations] = Report::Organization.new(@user).collection
      data[:organization_trends] = Report::Organization.new(@user).trends
    else
      data[:user_trends] = Report::User.new(@user).trends
    end

    user_report = Report::User.new(@user)
    content_report = Report::Content.new(@user)

    data[:channels] = Report::Channel.new(@user).collection
    data[:invites] = Report::Invite.new(@user).collection
    data[:users] = user_report.collection
    data[:role_distribution] = user_report.role_distribution
    data[:files] = content_report.files
    data[:content_type_distribution] = content_report.type_distribution

    data
  end
end



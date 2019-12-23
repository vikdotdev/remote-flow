module Report
  class BaseReport
    def initialize(user)
      @user = user
    end

    def collection
      if @user.super_admin?
        self.class.all
      else
        @user.organization.send(self.class.name.demodulize.pluralize.downcase.to_sym)
      end
    end
  end

  class User < BaseReport
    def trends
    end
  end

  class Organization < BaseReport
    def trends
    end
  end

  class Channel < BaseReport
  end

  class Content < BaseReport
    def files
      collection.where.not(file: nil)
    end
  end

  class Invite < BaseReport
  end
end

class Dashboard
  attr_reader :user, :organization

  def initialize(user)
    @user = user
  end

  def data
    data = Hash.new

    if user.super_admin?
      data[:organization_trends] = Report::Organization.new(@user).collection
    else
      data[:user_trends] = Report::User.new(@user).collection
    end

    data[:channels] = Report::Channel.new(@user).collection
    data[:invites] = Report::Invite.new(@user).collection

    content_report = Report::Content.new(@user)
    data[:content] = content_report.collection
    data[:files] = content_report.files

    data
  end
end

class Account::DashboardController < Account::AccountController
  def index
    @data = Dashboard.new(current_user).data
  end
end

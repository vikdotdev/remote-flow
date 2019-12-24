module Report
  class BaseReport
    def initialize(user)
      @user = user
    end

    def collection
      if @user.super_admin?
        self.class.name.demodulize.constantize.all
      else
        @user.organization.send(self.class.name.demodulize.pluralize.downcase)
      end
    end

    def trends
      series_data = []
      dates = []

      (30.days.ago.to_date..Date.today).each do |date|
        series_data.push(collection.where('created_at < ?', date.to_datetime).count)
        dates.push(date.day)
      end

      {
        series_data: series_data,
        dates: dates[2..-1]
      }
    end
  end

  class User < BaseReport
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

  class Content < BaseReport
    def files
      collection.where.not(file: nil)
    end

    def type_distribution
      {
        pages: {
          type: ::Content::PAGE,
          count: collection.where(type: ::Content::PAGE).count,
        },
        galleries: {
          type: ::Content::GALLERY,
          count: collection.where(type: ::Content::GALLERY).count,
        },
        presentations: {
          type: ::Content::PRESENTATION,
          count: collection.where(type: ::Content::PRESENTATION).count,
        },
        videos: {
          type: ::Content::VIDEO,
          count: collection.where(type: ::Content::VIDEO).count
        }
      }
    end
  end

  class Organization < BaseReport
  end

  class Channel < BaseReport
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

class Account::DashboardController < Account::AccountController
  def index
    @data = Dashboard.new(current_user).data
  end
end

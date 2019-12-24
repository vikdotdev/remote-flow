class Report::BaseReport
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


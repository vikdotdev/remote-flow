class BaseReport
  def initialize(user)
    @user = user
  end

  def collection
    klass_name = self.class.name.demodulize.sub('Report', '')
    if @user.super_admin?
      klass_name.constantize.all
    else
      @user.organization.send(klass_name.pluralize.downcase)
    end
  end

  def count
    collection.count
  end

  def trends
    series_data = []
    dates = []

    (30.days.ago.to_datetime..DateTime.now).each do |date|
      series_data.push(collection.where('created_at < ?', date.to_datetime).count)
      dates.push(date.day)
    end

    {
      series_data: series_data,
      dates: dates[2..-1]
    }
  end
end

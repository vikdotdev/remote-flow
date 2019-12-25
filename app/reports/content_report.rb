class ContentReport < BaseReport
  def file_count
    collection.where.not(file: nil).count
  end

  def type_distribution
    collection.group(:type).count
  end
end


class ContentReport < BaseReport
  def file_count
    collection.where.not(file: nil).count
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


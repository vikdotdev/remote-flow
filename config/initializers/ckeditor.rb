# frozen_string_literal: true

Ckeditor.setup do |config|
  # available as additional gems.
  require 'ckeditor/orm/active_record'

  config.image_file_types = %w(jpg jpeg png gif tiff)
end

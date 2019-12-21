# frozen_string_literal: true

Ckeditor.setup do |config|
  # available as additional gems.
  require 'ckeditor/orm/active_record'


  config.cdn_url = "//cdn.ckeditor.com/4.6.1/basic/ckeditor.js"
  config.image_file_types = %w(jpg jpeg png gif tiff)
end

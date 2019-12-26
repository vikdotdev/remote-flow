# frozen_string_literal: true

Ckeditor.setup do |config|
  require 'ckeditor/orm/active_record'

  config.cdn_url = "//cdn.ckeditor.com/4.13.1/standard-all/ckeditor.js"
  config.image_file_types = %w(jpg jpeg png gif tiff)
end

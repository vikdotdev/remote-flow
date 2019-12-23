# frozen_string_literal: true

Ckeditor.setup do |config|
  require 'ckeditor/orm/active_record'

  config.cdn_url = "//cdn.ckeditor.com/4.6.1/basic/ckeditor.js"
  config.js_config_url = "/assets/javascripts/ckeditor/config.js"
  config.image_file_types = %w(jpg jpeg png gif tiff)
end

require_relative 'boot'

require 'rails/all'
require 'csv'
Bundler.require(*Rails.groups)

module RemoteFlow
  class Application < Rails::Application
    config.load_defaults 6.0
    config.autoload_paths += %w(#{config.root}/app/models/ckeditor)
    config.assets.precompile += Ckeditor.assets
    config.assets.precompile += %w( ckeditor/* )

    config.generators do |g|
      g.template_engine :slim
    end

    config.hosts << 'localhost' << 'remote-flow.pp.ua'
  end
end

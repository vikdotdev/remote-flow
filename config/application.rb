require_relative 'boot'

require 'rails/all'
require 'csv'
Bundler.require(*Rails.groups)

module RemoteFlow
  class Application < Rails::Application
    config.load_defaults 6.0
    config.autoload_paths += %w(#{config.root}/app/models/ckeditor)

    config.generators do |g|
      g.template_engine :slim
    end

    config.hosts << "site.com"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

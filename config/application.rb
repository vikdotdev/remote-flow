require_relative 'boot'

require 'rails/all'
require 'csv'
Bundler.require(*Rails.groups)

module RemoteFlow
  class Application < Rails::Application
    config.load_defaults 6.0
    config.autoload_paths += %w(#{config.root}/app/models/ckeditor #{config.root}/app/lib)
    config.assets.precompile += Ckeditor.assets
    config.assets.precompile += %w( ckeditor/* )
    config.exceptions_app = self.routes

    config.generators do |g|
      g.template_engine :slim
    end

    config.hosts << 'localhost' << 'www.example.com' << 'remote-flow.pp.ua'

    config.filter_parameters << :password

    Raven.configure do |config|
      config.dsn = Rails.application.credentials[:sentry_dsn]
      config.environments = ['production']
    end
  end
end



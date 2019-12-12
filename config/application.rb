require_relative 'boot'

require 'rails/all'
require 'csv'
Bundler.require(*Rails.groups)

module RemoteFlow
  class Application < Rails::Application
    config.load_defaults 6.0

    config.generators do |g|
      g.template_engine :slim
    end
  end
end

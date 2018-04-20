require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module SweigApp
  class Application < Rails::Application
    config.load_defaults 5.1

    config.exceptions_app = self.routes

    I18n.enforce_available_locales = false
    I18n.config.available_locales = :da
    config.i18n.default_locale = :da

  end
end

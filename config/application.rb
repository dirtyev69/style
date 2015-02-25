require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Prod
  class Application < Rails::Application

    config.i18n.default_locale = :ru

    #config.assets.initialize_on_precompile = true

    I18n.enforce_available_locales = true

    # Enable the asset pipeline
    config.assets.enabled = true
  end
end

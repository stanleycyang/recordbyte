require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Recordbyte
  class Application < Rails::Application
   root.join('vendor', 'assets', 'bower_components').to_s.tap do |bower_path|
    config.sass.load_paths << bower_path
    config.assets.paths << bower_path
  end
  # Required for Cross-domain scripting
  config.action_dispatch.default_headers.merge!({
    'Access-Control-Allow-Origin' => '*',
    'Access-Control-Request-Method' => '*',
    'Access-Control-Allow-Methods' => 'GET, POST, OPTIONS, DELETE, PUT',
    'Access-Control-Allow-Headers' => 'Origin, Accept, Content-Type, X-Requested-With, X-CSRF-Token'
  })
  # Precompile Bootstrap fonts
  config.assets.precompile << %r(bootstrap-sass/assets/fonts/bootstrap/[\w-]+\.(?:eot|svg|ttf|woff2?)$)
  # Minimum Sass number precision required by bootstrap-sass
  ::Sass::Script::Number.precision = [8, ::Sass::Script::Number.precision].max 
  end
end

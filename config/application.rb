require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SimpleTwitter
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.time_zone = "Asia/Taipei"

    config.filestack_rails.api_key = "APkKnpC1uRG2WeteQ05rQz"
    config.filestack_rails.client_name = "simple_twitter"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end

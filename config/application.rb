require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Myground
  class Application < Rails::Application
    config.load_defaults 6.1
    config.time_zone = 'Asia/Tokyo'

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: false,
        view_specs: false,
        helper_specs: false,
        routing_specs: false
      g.factory_bot false
    end
  end
end

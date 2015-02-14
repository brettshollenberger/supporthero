require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Supporthero
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework = :rspec
    end
  end
end

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DesafioBackend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    %w[services].each do |main_folder|
      Dir.glob("#{config.root}/app/#{main_folder}/**/*")
         .select { |file| File.directory?(file) }
         .each do |path|
        config.paths.add path, eager_load: true
      end
    end
  end
end
require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PrefectureQuiz
  class Application < Rails::Application
    config.load_defaults 7.0
    
    config.generators do |g|
      g.skip_routes true
      g.assets false
      g.helper false
      g.test_framework false

    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }

    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    end
  end
end

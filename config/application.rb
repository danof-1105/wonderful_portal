require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module WonderfulPortal
  class Application < Rails::Application
    config.load_defaults 6.1

    # 標準言語とタイムゾーンを日本に変更
    config.i18n.default_locale = :ja
    config.time_zone = "Asia/Tokyo"

    config.generators do |g|
      g.template_engine :erb
      g.assets false
      g.helper false
      g.test_framework :rspec,
                       view_specs: false,
                       routing_specs: false,
                       helper_specs: false,
                       controller_specs: false,
                       request_specs: false,
                       system_specs: false
    end
  end
end

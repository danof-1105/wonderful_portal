require "slack-notifier"

module ErrorHandler
  extend ActiveSupport::Concern

  included do
    if Rails.env.production?
      rescue_from Exception, with: :render_500
      rescue_from ::ActiveRecord::RecordNotFound, with: :redirect_root
    end
  end

  def redirect_root
    redirect_to root_url
  end

  def render_500(e)
    send_error_message(e)
    render file: "#{Rails.root}/public/500.html", layout: false, status: 500
  end

  private

    def send_error_message(e)
      message = <<~TEXT
        *【#{Rails.env}】 予期せぬエラーが発生しました*
        *Error:* #{e.inspect}
        *Error Point:* #{e.backtrace.first}
      TEXT

      webhook_url = ENV['SLACK_WEBHOOK_URL']
      notifier = Slack::Notifier.new(webhook_url)
      notifier.ping(message)
    end
end

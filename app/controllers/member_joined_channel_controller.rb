class MemberJoinedChannelController < ApplicationController
  before_action :authenticate_user!, except: [:callback]
  def callback
    @body = JSON.parse(request.body.read)
    case @body['type']
      when 'url_verification'
        render json: @body
      when 'event_callback'
        # ここにイベントを受け取った際のバッチ処理
    end
  end
end

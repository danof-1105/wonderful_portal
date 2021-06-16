class CommunitiesController < ApplicationController
  PER_PAGE = 10

  def new
    @community = current_user.communities.new
  end

  def index
    @communities = current_user.communities
    @communities = @communities.page(params[:page]).per(PER_PAGE)
  end

  def create
    # FIXME: 重複コミュニティバリエーション or "既に存在するコミュニティ名です" の文言
    @community = current_user.communities.create!(name: params[:community][:name], owner: current_user)

    flash[:success] = "#{@community.name}コミュニティーを作成しました。"
    redirect_back(fallback_location: root_path)
  end
end

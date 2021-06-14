class CommunitiesController < ApplicationController
  PER_PAGE = 10

  def index
    @communities = current_user.communities
    @communities = @communities.page(params[:page]).per(PER_PAGE)
  end

  def create
    @community = current_user.communities.create!(name: params[:name], owner: current_user)

    flash[:success] = "#{@community.name}コミュニティーを作成しました。"
    redirect_back(fallback_location: root_path)
  end
end

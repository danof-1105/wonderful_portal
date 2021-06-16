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
    community_name = params[:community][:name]

    if community_name.empty?
      flash[:danger] = "入力されていません。"
      return redirect_back(fallback_location: root_path)
    end

    unless Community.find_by(name: community_name)
      @community = current_user.communities.create!(name: community_name, owner: current_user)
      flash[:primary] = "#{@community.name}コミュニティーを作成しました。"

      return redirect_back(fallback_location: root_path)
    end

    flash[:warning] = "#{community_name}コミュニティーは既に作成されています。"
    redirect_back(fallback_location: root_path)
  end
end

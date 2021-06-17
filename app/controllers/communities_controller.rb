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
    @community = current_user.communities.new(name: community_create_params, owner: current_user)

    if @community.valid?
      current_user.communities.create!(name: community_create_params, owner: current_user)
      flash[:primary] = "#{@community.name}コミュニティーを作成しました。"
      redirect_to communities_path
    else
      flash.now[:danger] = "#{@community.name}コミュニティーを作成できませんでした。"
      render :new
    end
  end

  private

    def community_create_params
      params.require(:community).permit(:name).values[0]
    end
end

class CommunitiesController < ApplicationController
  before_action :authenticate_admin, only: [:new, :create]
  PER_PAGE = 10

  def new
    @community = current_user.communities.new
  end

  def index
    @communities = current_user.communities
    @communities = @communities.page(params[:page]).per(PER_PAGE)
  end

  def create
    @community = current_user.communities.new(community_create_params.merge(owner: current_user))

    if @community.valid?
      current_user.communities.create!(community_create_params.merge(owner: current_user))
      flash[:primary] = "#{@community.name}コミュニティーを作成しました。"
      redirect_to communities_path
    else
      flash.now[:danger] = "#{@community.name}コミュニティーを作成できませんでした。"
      render :new
    end
  end

  private

    def community_create_params
      params.require(:community).permit(:name)
    end

    def authenticate_admin
      redirect_to communities_path unless current_user.admin?
    end
end

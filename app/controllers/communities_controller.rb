class CommunitiesController < ApplicationController
  before_action :user_admin, only: [:new]
  PER_PAGE = 10

  def new
    @community = current_user.communities.new
  end

  def index
    @communities = current_user.communities
    @communities = @communities.page(params[:page]).per(PER_PAGE)
  end

  def create
    @community = current_user.communities.new(community_create_params)

    if @community.valid?
      current_user.communities.create!(community_create_params)
      flash[:primary] = "#{@community.name}コミュニティーを作成しました。"
      redirect_to communities_path
    else
      flash.now[:danger] = "#{@community.name}コミュニティーを作成できませんでした。"
      render :new
    end
  end

  private

    def community_create_params
      params.require(:community).permit(:name).merge(owner: current_user)
    end

    def user_admin
      if current_user.admin == false
        redirect_to communities_path
      else
        render action: "new"
      end
    end
end

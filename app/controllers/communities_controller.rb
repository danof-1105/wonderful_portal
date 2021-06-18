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

  def create # rubocop:disable Metrics/AbcSize
    @community = current_user.communities.new(community_create_params.merge(owner: current_user))

    if @community.valid?
      @community = current_user.communities.create!(community_create_params.merge(owner: current_user))
      @community.slack_cooperation = (@community.slack_access_token.present? ? true : false)
      flash[:primary] = "#{@community.name}コミュニティーを作成しました。"
      redirect_to communities_path
    else
      render :new
    end
  end

  private

    def community_create_params
      params.require(:community).permit(:name, :slack_access_token)
    end

    def authenticate_admin
      redirect_to communities_path unless current_user.admin?
    end
end

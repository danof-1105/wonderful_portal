class CommunitiesController < ApplicationController
  PER_PAGE = 10

  def index
    @communities = Community.all
    @communities = @communities.page(params[:page]).per(PER_PAGE)
  end
end

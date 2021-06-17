class CommunitiesController < ApplicationController
  PER_PAGE = 10

  def new
    @community = current_user.communities.new
  end

  def index
    @communities = current_user.communities
    @communities = @communities.page(params[:page]).per(PER_PAGE)
  end

  # be rails generate scaffold community
  # POST /communities or /communities.json
  # def create
  # # binding.pry
  #   @community = Community.new(community_params)

  #   if @community.save
  #     redirect_to @community, notice: "Community was successfully created."
  #   else
  #     render :new
  #   end
  # end

  # strong_params 使う

  # uniqeness

  def create
    @community = current_user.communities.new(name: params[:community][:name], owner: current_user)

    # バリテーションのチェック ここだけ
    # 次に処理
    # DBに登録する処理 > SQL : 成功してる
    if @community.save
      binding.pry
      flash[:primary] = "#{@community.name}コミュニティーを作成しました。"
      redirect_to communities_path
    else
      render :new
    end
  end

  # 違い：
  # - redirect_to: 全部データが消える。　router  を見に行く

  # - render は flash は使えない?? なぜ flash.now[:]


  # - render : 再描写され、new を描写しろよ!


  # 保留
  # def create
  #   community_name = params[:community][:name]

  #   if community_name.empty?
  #     flash[:danger] = "入力されていません。"
  #     return redirect_back(fallback_location: root_path)
  #   end

  #   unless Community.find_by(name: community_name)
  #     @community = current_user.communities.create!(name: community_name, owner: current_user)
  #     flash[:primary] = "#{community_name}コミュニティーを作成しました。"

  #     return redirect_back(fallback_location: root_path)
  #   end

  #   flash[:warning] = "#{community_name}コミュニティーは既に作成されています。"
  #   redirect_back(fallback_location: root_path)
  # end

  # private

  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_community
  #     @community = Community.find(params[:id])
  #   end

  #   # Only allow a list of trusted parameters through.
  #   def community_params
  #     params.fetch(:community, {})
  #   end
end

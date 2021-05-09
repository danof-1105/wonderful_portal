class DocumentsController < ApplicationController
  def new
    @document = current_user.documents.new
  end

  def index
    @user_directories = UserDirectory.arrange
    if params[:directory_id]
      target_directory = current_user.user_directories.find(params[:directory_id])
      target_directory_ids = target_directory.descendant_ids.push(target_directory.id)
    end
    # HACK: 分かりやすいコードに改善余地あり
    @documents = target_directory_ids ? Document.where(user_directory: target_directory_ids) : Document.all
  end

  def show
    @document = current_user.have_documents.find(params[:id])
    @directory = @document.user_directory.path.pluck(:name)
  end

  def create
    # TODO: モック部、Devise実装後に修正必要
    user_directory = current_user.user_directories.first
    add_params = { owner: current_user, user_directory: user_directory }
    @document = current_user.documents.create!(document_params.merge(add_params))
    redirect_to @document, notice: "ドキュメントを登録しました。"
  end

  def document_params
    params.require(:document).permit(:title, :body)
  end
end

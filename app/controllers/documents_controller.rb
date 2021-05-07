class DocumentsController < ApplicationController
  def new
    @document = Document.new
  end

  def show
    current_user = User.first
    @document = current_user.have_documents.find(params[:id])
    @directory = @document.user_directory.path.pluck(:name)
  end

  def create
    # TODO: モック部、Devise実装後に修正必要
    current_user = User.first
    user_directory = UserDirectory.first
    example = { owner: current_user, user_directory: user_directory }
    image = params[:document][:image_path]
    if image.present?
      document_image = DocumentImage.create!(document_image_params)
      title = params[:document][:title]
      body = params[:document][:body] << ("\n ![#{document_image.image_path}]")
      document = current_user.documents.create!(title: title, body: body, owner: current_user, user_directory: user_directory)
    else
      document = current_user.documents.create!(document_params.merge(example))
    end
    redirect_to document, notice: "ドキュメントを登録しました。"
  end

  def document_params
    params.require(:document).permit(:title, :body)
  end

  def document_image_params
    params.require(:document).permit(:image_path)
  end
end

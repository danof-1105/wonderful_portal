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
    images = params[:document][:image]
    title = params[:document][:title]
    body = params[:document][:body]

    if images.present?
      images.each do |image|
        document_image = DocumentImage.create!(image: image)
        body << "\n ![#{document_image.image_identifier}](#{document_image.image_url})"
      end
    end

    hoge = {
      title: title,
      body: body,
      owner: current_user,
      user_directory: user_directory,
    }

    document = current_user.documents.create!(hoge)
    redirect_to document, notice: "ドキュメントを登録しました。"
  end
end

class DocumentsController < ApplicationController
  def new
    @document = current_user.documents.new
  end

  def index
    @user_directories = UserDirectory.arrange
    @documents = current_user.have_documents.limit(7)
    @document = @documents.page(params[:page])
  end

  def show
    @document = current_user.have_documents.find(params[:id])
    @directory = @document.user_directory.path.pluck(:name)
  end

  def create
    images = params[:document][:image]
    title = params[:document][:title]
    body = params[:document][:body]

    if images.present?
      images.each do |image|
        document_image = DocumentImage.create!(image: image)
        body << "\n ![#{document_image.image_identifier}](#{document_image.image_url})"
      end
    end

    document_elements = {
      title: title,
      body: body,
      owner: current_user,
      user_directory: user_directory,
    }

    document = current_user.documents.create!(document_elements)
    redirect_to document, notice: "ドキュメントを登録しました。"
  end
end

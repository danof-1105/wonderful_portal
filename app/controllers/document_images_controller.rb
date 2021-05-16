class DocumentImagesController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    resource = DocumentImage.create!(image: params[:image])
    url = resource.image.url
    filename = resource.image.filename

    render json: { url: url, filename: filename }
  end
end

class DocumentsController < ApplicationController
  def show
    @document = Document.find(params[:id])
    @directory = @document.user_directory.path.pluck(:name)
  end
end

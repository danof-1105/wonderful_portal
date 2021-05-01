class DocumentsController < ApplicationController
  def show
    @document = current_user.have_documents.find(params[:id])
    @directory = @document.user_directory.path.pluck(:name)
  end
end

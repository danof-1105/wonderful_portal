class DocumentsController < ApplicationController
  def show
    @document = current_user.documents.find(params[:id])
    @directory = @document.user_directory.path.pluck(:name)
  end
end

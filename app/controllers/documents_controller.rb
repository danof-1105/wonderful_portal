class DocumentsController < ApplicationController
  def new
    @document = Document.new
  end

  def create
    # TODO: モック部、Devise実装後に修正必要
    current_user = User.first
    user_directory = UserDirectory.first
    example  = {owner: current_user, user_directory: user_directory}
    @document = current_user.documents.create!(document_params.merge(example))
  end

  def document_params
    params.require(:document).permit(:title, :body)
  end
end

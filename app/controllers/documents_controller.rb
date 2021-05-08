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
    directories_and_title = params[:document][:title_with_directory].split("/")
    title = directories_and_title.pop
    ActiveRecord::Base.transaction do
      first_directory_name = directories_and_title.blank? ? "指定なし" : directories_and_title[0]
      prev_directory = current_user.user_directories.find_or_create_by!(name: first_directory_name, ancestry: nil)
      directories_and_title.each_with_index do |directory_name, i|
        next if i == 0

        prev_directory = prev_directory.children.find_or_create_by!(name: directory_name, user: current_user)
      end
      add_params = { title: title, owner: current_user, user_directory: prev_directory }
      @document = current_user.documents.create!(document_params.merge(add_params))
    end
    redirect_to @document, notice: "ドキュメントを登録しました。"
  end

  def document_params
    params.require(:document).permit(:title_with_directory, :body)
  end
end

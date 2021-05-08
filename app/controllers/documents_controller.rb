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
    # TODO: モック部、Devise実装後に修正必要
    title_with_directory = params[:document][:title_with_directory].split("/")
    title = title_with_directory[-1]
    case title_with_directory.length
    when 1
      if current_user.user_directories.exists?(name: "no category")
        add_params = { title: title, owner: current_user, user_directory: current_user.user_directories.find_by(name: "no category") }
        @document = current_user.documents.create!(document_params.merge(add_params))
      else
        current_user.user_directories.create!(name: "no category")
        add_params = { title: title, owner: current_user, user_directory: current_user.user_directories.find_by(name: "no category") }
        @document = current_user.documents.create!(document_params.merge(add_params))
      end
    when 2
      parents_directory = title_with_directory[0]
      if current_user.user_directories.exists?(name: parents_directory)
        add_params = { title: title, owner: current_user, user_directory: current_user.user_directories.find_by(name: parents_directory) }
        @document = current_user.documents.create!(document_params.merge(add_params))
      else
        current_user.user_directories.create!(name: parents_directory)
        add_params = { title: title, owner: current_user, user_directory: current_user.user_directories.find_by(name: parents_directory) }
        @document = current_user.documents.create!(document_params.merge(add_params))
      end
    when 3
      parents_directory = title_with_directory[0]
      children_directory = title_with_directory[1]
      if current_user.user_directories.exists?(name: parents_directory)
        add_params = { title: title, owner: current_user, user_directory: current_user.user_directories.find_by(name: children_directory) }
        @document = current_user.documents.create!(document_params.merge(add_params))
      else
        current_user.user_directories.create!(name: parents_directory)
      end





    end
    redirect_to @document, notice: "ドキュメントを登録しました。"
  end

  def document_params
    params.require(:document).permit(:title_with_directory, :body)
  end
end

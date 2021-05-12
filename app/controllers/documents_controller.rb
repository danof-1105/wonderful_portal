class DocumentsController < ApplicationController
  def new
    @document = current_user.documents.new
  end

  def index
    @user_directories = UserDirectory.arrange
    if params[:directory_id]
      target_directory = current_user.user_directories.find(params[:directory_id])
      target_directory_ids = target_directory.descendant_ids.push(target_directory.id)
    end
    # HACK: 分かりやすいコードに改善余地あり
    @documents = target_directory_ids ? Document.where(user_directory: target_directory_ids) : Document.all
  end

  def show
    @document = current_user.have_documents.find(params[:id])
    @directory = @document.user_directory.path.pluck(:name)
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def create
    # Description: タイトルの文字列を / 毎に配列に直す
    directories_and_title = params[:document][:title_with_directory].split("/")
    # Description: タイトル名は配列の一番後ろなので pop で取り出す
    title = directories_and_title.pop
    ActiveRecord::Base.transaction do
      # Description: タイトル記入欄にタイトルのみしか記載されていない場合は"指定なし" そうでない場合は一番親のディレクトリ名を取り出す
      first_directory_name = directories_and_title.blank? ? "指定なし" : directories_and_title[0]
      # Description: 取り出したディレクトリ名で prev_directory という変数名でディレクトリを保存、既に同じ名前のディレクトリがある場合はそのディレクトリを参照
      prev_directory = current_user.user_directories.find_or_create_by!(name: first_directory_name, ancestry: nil)
      # Description: 最初に定義した directories_and_title は pop でタイトルだけ取り出されているため、残ったディレクトリを each で親から順番に回す
      directories_and_title.each_with_index do |directory_name, i|
        # Description: 一番親のディレクトリは prev_directory で定義済みのため、スルー
        next if i == 0

        # Description: prev_directory の子ディレクトリを each で取り出したディレクトリ名でオーバーライドし保存 or 参照(find_or_create_by)を繰り返す
        prev_directory = prev_directory.children.find_or_create_by!(name: directory_name, user: current_user)
      end

      images = params[:document][:image]
      body = params[:document][:body]

      if images.present?
        images.each do |image|
          document_image = DocumentImage.create!(image: image)
          body << "\n ![#{document_image.image_identifier}](/uploads/tmp/document_image/#{document_image.image_identifier})"
        end
      end

      document_elements = {
        title: title,
        body: body,
        owner: current_user,
        user_directory: prev_directory,
        title_with_directory: directories_and_title,
      }
      @document = current_user.documents.create!(document_elements)
    end
    redirect_to @document, notice: "ドキュメントを登録しました。"
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
end

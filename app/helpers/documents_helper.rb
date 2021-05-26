module DocumentsHelper

  def placeholder_text
    action_name == "new" ? "タイトル" : ""
  end

  def value_text
    action_name == "edit" ? "#{@all_directories}/#{@title}" : ""  # rubocop:disable  Rails/HelperInstanceVariable
  end
end

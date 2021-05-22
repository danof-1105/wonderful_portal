module DocumentsHelper
  def button_text
    action_name == "new" ? "作成" : "更新"
  end

  def placeholder_text
    action_name == "new" ? "タイトル" : ""
  end

  def value_text
    action_name == "edit" ? "#{@all_directories}/#{@title}" : ""
  end
end

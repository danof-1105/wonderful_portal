module DocumentsHelper
  def button_text
    action_name == "new" ? "作成" : "更新"
  end

  def placeholder_text
    action_name == "new" ? "タイトル" : "#{@all_directories}/#{@title}"
  end
end

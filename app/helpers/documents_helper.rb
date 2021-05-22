module DocumentsHelper
  def button_text
    if action_name == "new"
      "作成"
    elsif action_name == "edit"
      "更新"
    end
  end
end

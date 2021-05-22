module DocumentsHelper
  def button_text
    action_name == "new" ? "作成" : "更新"
  end
end

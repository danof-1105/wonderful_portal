module ApplicationHelper
  def text_color
    case controller.action_name
    when "index"
      "text-light"
    else
      "text-danger"
    end
  end
end

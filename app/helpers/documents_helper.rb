module DocumentsHelper

  def value_text
    action_name == "edit" ? "#{@all_directories}/#{@title}" : ""  # rubocop:disable  Rails/HelperInstanceVariable
  end
end

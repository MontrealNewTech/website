module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Les Pitonneux'
    if page_title.blank?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  def show_error(object, field)
    messages = object.errors.full_messages_for field
    return if messages.empty?
    content_tag :p, messages.first.lstrip, class: 'field-error'
  end
end

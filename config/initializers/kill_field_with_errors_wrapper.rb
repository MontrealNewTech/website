# frozen_string_literal: true
ActionView::Base.field_error_proc = proc do |html_tag, _instance|
  class_attr_index = html_tag.index 'class="'

  if class_attr_index
    html_tag.insert class_attr_index + 7, 'error '
  else
    html_tag.insert html_tag.index('>'), ' class="error"'
  end
end

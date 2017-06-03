# frozen_string_literal: true
module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Montreal Newtech'
    if page_title.blank?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  def meta_description(meta)
    return t('meta.main') if meta.blank?
    meta
  end

  def show_error(object, field)
    messages = object.errors.full_messages_for field
    return if messages.empty?
    content_tag :p, messages.first.lstrip, class: 'field-error'
  end

  def google_search_link(destination)
    return if destination.nil?
    query = destination.tr(' ', '+')
    url = "https://www.google.com/maps/search/#{query}"
    link_to destination, url, target: '_blank', class: 'map fixed-width-icon'
  end

  def hyperlink_urls(text, options = nil)
    return if text.nil?
    hyperlinked_text = Rinku.auto_link(text, :all, 'target="_blank"') do |url|
      url.first(25) + '... '
    end

    content_tag :p, hyperlinked_text.html_safe, options
  end
end

# frozen_string_literal: true
class EmptyCalendarDayEvent < BaseEvent
  def display_time
    I18n.t('no_events')
  end
end

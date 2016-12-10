# frozen_string_literal: true
class EmptyCalendarDayEvent
  def self.on(date)
    new(date)
  end

  def initialize(date)
    @date = date
  end

  def start_at
    @date
  end

  def title
    I18n.t('events.empty_day')
  end

  def description
    nil
  end

  def location
    nil
  end

  def link
    nil
  end
end

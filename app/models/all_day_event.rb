class AllDayEvent < BaseEvent
  def display_time
    I18n.t('all_day_event')
  end
end

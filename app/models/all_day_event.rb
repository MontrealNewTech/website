class AllDayEvent < BaseEvent
  def display_time
    I18n.t('all_day_event', start: start, finish: finish)
  end

  private

  def start
    I18n.l(start_at, format: :date_time)
  end

  def finish
    I18n.l(end_at, format: :date_time)
  end
end

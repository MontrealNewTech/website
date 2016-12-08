class EventForEmptyDay
  def summary
    I18n.t('events.empty_day')
  end

  def start
    OpenStruct.new(:date_time)
  end

  def location
    nil
  end
end

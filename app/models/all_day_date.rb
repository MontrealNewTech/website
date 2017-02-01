# frozen_string_literal: true
class AllDayDate
  def strftime(_format)
    I18n.t('models.all_day_date.all_day')
  end
end

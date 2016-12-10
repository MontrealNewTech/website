# frozen_string_literal: true
EmptyCalendarDayEvent = KeywordStruct.new(*(Event::ATTRIBUTES - [:start_at])) do
  def start_at
    NullDate.new('events')
  end
end

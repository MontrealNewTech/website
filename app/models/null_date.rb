class NullDate
  def initialize(nullable)
    @nullable = nullable
  end

  def strftime(_format)
    I18n.t('models.null_date.strftime', nullable: @nullable)
  end

  def mon
    1
  end
end

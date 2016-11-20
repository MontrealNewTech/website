class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  def default_url_options(_options={})
    { locale: I18n.locale }
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end

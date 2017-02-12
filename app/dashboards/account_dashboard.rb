# frozen_string_literal: true
require 'administrate/base_dashboard'

class AccountDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    user_email: Field::String,
    admin: FriendlyBooleanField
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :user_email,
    :admin
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :user_email,
    :admin
  ].freeze

  FORM_ATTRIBUTES = [
    :admin
  ].freeze

  def display_resource(account)
    I18n.t('administrate.display.account', email: account.user_email)
  end
end

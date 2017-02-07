require 'administrate/base_dashboard'

class AccountDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    user_email: Field::String,
    admin: Field::Select.with_options(
      collection: ["Yes", "No"]
    )
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
    "Account for #{account.user_email}"
  end
end

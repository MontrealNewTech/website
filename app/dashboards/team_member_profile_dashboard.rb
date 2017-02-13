# frozen_string_literal: true
require 'administrate/base_dashboard'

class TeamMemberProfileDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::Number,
    team: Field::BelongsTo,
    id: Field::Number,
    name: Field::String,
    position: Field::String,
    bio: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :name,
    :position,
    :team,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :user,
    :name,
    :position,
    :bio,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :user,
    :team,
    :bio,
    :name,
    :position,
  ].freeze

  # Overwrite this method to customize how team members are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(team_member)
  #   "TeamMember ##{team_member.id}"
  # end
end

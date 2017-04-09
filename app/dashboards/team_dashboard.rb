# frozen_string_literal: true
require 'administrate/base_dashboard'

class TeamDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    member_profiles: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    description: Field::Text,
    name_en: Field::String,
    description_en: Field::Text,
    name_fr: Field::String,
    description_fr: Field::Text,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :name_en,
    :description_en,
    :member_profiles,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :member_profiles,
    :id,
    :name_en,
    :description_en,
    :name_fr,
    :description_fr
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name_en,
    :description_en,
    :name_fr,
    :description_fr,
    :member_profiles
  ].freeze

  def display_resource(team)
    team.name
  end
end

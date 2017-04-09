# frozen_string_literal: true
require 'administrate/base_dashboard'

class PartnershipDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    name: Field::String,
    description: Field::Text,
    name_en: Field::String,
    description_en: Field::Text,
    name_fr: Field::String,
    description_fr: Field::Text,
    logo: FileField,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :name_en,
    :description_en,
    :logo,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :name_en,
    :description_en,
    :name_fr,
    :description_fr,
    :logo,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name_en,
    :description_en,
    :name_fr,
    :description_fr,
    :logo,
  ].freeze

  def display_resource(partner)
    partner.name
  end

  def permitted_attributes
    super.concat [:logo_cache]
  end
end

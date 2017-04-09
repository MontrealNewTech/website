# frozen_string_literal: true
require 'administrate/base_dashboard'

class MemberProfileDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user_email: Field::Text,
    user: NoLinkBelongsToField,
    team: Field::BelongsTo,
    id: Field::Number,
    name: Field::String,
    position: Field::String,
    bio: Field::Text,
    position_en: Field::String,
    bio_en: Field::Text,
    position_fr: Field::String,
    bio_fr: Field::Text,
    image: FileField,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :image,
    :name,
    :position_en,
    :team,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :name,
    :user_email,
    :image,
    :team,
    :position_en,
    :bio_en,
    :position_fr,
    :bio_fr,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name,
    :user,
    :team,
    :image,
    :position_en,
    :bio_en,
    :position_fr,
    :bio_fr,
  ].freeze

  def display_resource(member)
    member.name
  end

  def permitted_attributes
    super.concat [:image_cache]
  end
end

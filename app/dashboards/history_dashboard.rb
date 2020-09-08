require "administrate/base_dashboard"

class HistoryDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    user_id: Field::Number,
    user_name: Field::String,
    details: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    total_value: Field::Number,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :user_name,
    :details,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :user_id,
    :user_name,
    :details,
    :created_at,
    :updated_at,
    :total_value,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :user_id,
    :user_name,
    :details,
    :total_value,
  ].freeze

  # Overwrite this method to customize how histories are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(history)
  #   "History ##{history.id}"
  # end
end

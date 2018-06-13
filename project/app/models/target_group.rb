class TargetGroup < ApplicationRecord
  belongs_to :panel_provider
  has_and_belongs_to_many :countries
  # self join relation
  has_many :children, class_name: name, foreign_key: 'parent_id'
  belongs_to :parent, class_name: name, optional: true

  scope :roots, -> { where parent_id: nil }
  scope :for_panel_provider, ->(provider_id) { where panel_provider_id: provider_id }
end

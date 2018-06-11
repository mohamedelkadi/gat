class TargetGroup < ApplicationRecord
  belongs_to :panel_provider
  has_and_belongs_to_many :countries
  # self join relation
  has_many :children, class_name: name, foreign_key: 'parent_id'
  belongs_to :parent, class_name: name, optional: true
end

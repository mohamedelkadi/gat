class CreateLocationGroupsLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :location_groups_locations do |t|
      t.integer :location_id
      t.integer :location_group_id
    end
  end
end

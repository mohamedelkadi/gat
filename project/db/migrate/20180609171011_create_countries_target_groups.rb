class CreateCountriesTargetGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :countries_target_groups do |t|
      t.integer :country_id
      t.integer :target_group_id
    end
  end
end

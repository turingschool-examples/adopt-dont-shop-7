class FixCreateApplication < ActiveRecord::Migration[7.0]
  def change
    remove_column :applications, :pet_names
  end
end

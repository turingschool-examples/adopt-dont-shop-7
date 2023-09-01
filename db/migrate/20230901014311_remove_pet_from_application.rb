class RemovePetFromApplication < ActiveRecord::Migration[7.0]
  def change
    remove_column :applications, :pet_id
  end
end

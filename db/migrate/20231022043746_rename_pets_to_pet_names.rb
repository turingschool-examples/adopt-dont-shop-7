class RenamePetsToPetNames < ActiveRecord::Migration[7.0]
  def change
    rename_column :applications, :pets, :pet_names
  end
end

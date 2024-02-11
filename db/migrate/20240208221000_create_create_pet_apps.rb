class CreateCreatePetApps < ActiveRecord::Migration[7.1]
  def change
    create_table :pet_apps do |t|
      t.references :application, null: false, foreign_key: true
      t.references :pet, null: false, foreign_key: true
      t.integer :pet_status, default: 0 

      t.timestamps
    end
  end
end

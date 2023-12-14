class CreatePetApps < ActiveRecord::Migration[7.0]
  def change
    create_table :pet_apps do |t|
      t.references :application, null: false, foreign_key: true
      t.references :pet, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end

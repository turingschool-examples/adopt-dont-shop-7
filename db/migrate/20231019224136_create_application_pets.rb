class CreateApplicationPets < ActiveRecord::Migration[7.0]
  def change
    create_table :application_pets do |t|
      t.references :pet, null: false, foreign_key: true
      t.references :application, null: false, foreign_key: true
      t.string :name, null: true
      t.boolean :adoptable, null: true

      t.timestamps
    end
  end
end

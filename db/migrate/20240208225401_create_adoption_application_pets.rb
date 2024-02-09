class CreateAdoptionApplicationPets < ActiveRecord::Migration[7.1]
  def change
    create_table :adoption_application_pets do |t|
      t.references :pet, null: false, foreign_key: true
      t.references :adoption_application, null: false, foreign_key: true

      t.timestamps
    end
  end
end

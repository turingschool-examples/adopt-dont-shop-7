class CreateApplicationPetsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_table :application_pets, id: false do |t|
      t.bigint :application_id, null: false
      t.bigint :pet_id, null: false
      t.integer "status", default: 0
      
      t.timestamps
    end

    add_index :application_pets, [:application_id, :pet_id], unique: true
    add_foreign_key :application_pets, :applications
    add_foreign_key :application_pets, :pets
  end
end

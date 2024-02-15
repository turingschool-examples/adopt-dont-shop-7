class AddPetStatustoApplicationPets < ActiveRecord::Migration[7.1]
  def change
    add_column :application_pets, :pet_status, :integer, default: 0, null: false
  end
end

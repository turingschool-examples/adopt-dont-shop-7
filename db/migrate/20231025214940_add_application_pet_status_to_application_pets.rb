class AddApplicationPetStatusToApplicationPets < ActiveRecord::Migration[7.0]
  def change
    add_column :application_pets, :application_pet_status, :integer, default: 1
  end
end

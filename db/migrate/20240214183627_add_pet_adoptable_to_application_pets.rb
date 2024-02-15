class AddPetAdoptableToApplicationPets < ActiveRecord::Migration[7.1]
  def change
    add_column :application_pets, :pet_adoptable, :string, default: "N/A"
  end
end

class AddAppPetStatusToApplicationPets < ActiveRecord::Migration[7.0]
  def change
    add_column :application_pets, :app_pet_status, :string
  end
end

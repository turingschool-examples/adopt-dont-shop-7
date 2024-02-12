class AddStatusToAdoptionApplicationPets < ActiveRecord::Migration[7.1]
  def change
    add_column :adoption_application_pets, :status, :string
  end
end

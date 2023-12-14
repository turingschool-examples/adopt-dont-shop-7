class AddStatusToApplicationPets < ActiveRecord::Migration[7.0]
  def change
    add_column :application_pets, :status, :string
  end
end

# row 1: id 1, application_id 1, pet_id 1, status 
# row 2: id 2, application_id 2, pet_id 1, status
# row 3: id 3, application_id 2, pet_id 2, status 

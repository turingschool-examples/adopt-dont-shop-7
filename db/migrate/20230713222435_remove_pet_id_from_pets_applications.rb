class RemovePetIdFromPetsApplications < ActiveRecord::Migration[7.0]
  def change
    remove_column :pets_applications, :pet_id, :integer
  end
end

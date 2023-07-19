class AddPetDescriptionToApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :applications, :pet_description, :string
  end
end

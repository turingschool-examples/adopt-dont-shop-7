class AddDefaultPetDescriptionToApplications < ActiveRecord::Migration[7.0]
  def change
    change_column :applications, :pet_description, :string, default: "n/a"

  end
end

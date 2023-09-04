class AddAdoptionDescriptionToApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :applications, :adoption_description, :string
  end
end

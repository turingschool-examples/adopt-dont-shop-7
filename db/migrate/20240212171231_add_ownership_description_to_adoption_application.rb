class AddOwnershipDescriptionToAdoptionApplication < ActiveRecord::Migration[7.1]
  def change
    add_column :adoption_applications, :ownership_description, :string
  end
end

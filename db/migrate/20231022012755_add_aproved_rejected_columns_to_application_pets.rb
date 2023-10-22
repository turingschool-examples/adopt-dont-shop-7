class AddAprovedRejectedColumnsToApplicationPets < ActiveRecord::Migration[7.0]
  def change
    add_column :application_pets, :approved, :boolean
    add_column :application_pets, :rejected, :boolean
    change_column_default :application_pets, :approved, false
    change_column_default :application_pets, :rejected, false
  end
end

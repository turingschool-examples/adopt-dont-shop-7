class AddColumnToApplicationPets < ActiveRecord::Migration[7.0]
  def change
    add_column :application_pets, :application_approved, :boolean, default: nil
  end
end

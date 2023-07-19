class AddDefaultStatusToApplicationPets < ActiveRecord::Migration[7.0]
  def change
    change_column :application_pets, :status, :string, default: "Pending"
  end
end

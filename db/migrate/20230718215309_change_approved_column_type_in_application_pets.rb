class ChangeApprovedColumnTypeInApplicationPets < ActiveRecord::Migration[7.0]
  def change
    change_column :application_pets, :approved, :string, default: "pending"
  end
end

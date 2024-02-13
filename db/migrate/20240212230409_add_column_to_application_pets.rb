class AddColumnToApplicationPets < ActiveRecord::Migration[7.1]
  def change
    add_column :application_pets, :status, :string, :default => "Pending"
  end
end

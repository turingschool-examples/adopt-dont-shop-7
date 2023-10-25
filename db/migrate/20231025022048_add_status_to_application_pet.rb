class AddStatusToApplicationPet < ActiveRecord::Migration[7.0]
  def change
    add_column :application_pets, :status, :boolean
  end
end

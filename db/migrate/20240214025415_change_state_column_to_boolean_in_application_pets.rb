class ChangeStateColumnToBooleanInApplicationPets < ActiveRecord::Migration[7.1]
  def change
    remove_column :application_pets, :state, :string
    add_column :application_pets, :state, :boolean
  end
end

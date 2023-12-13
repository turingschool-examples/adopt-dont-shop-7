class AddPrimaryKeyToApplicationPets < ActiveRecord::Migration[7.0]
  def change
    add_column :application_pets, :id, :primary_key
  end
end
# how/when did that happen
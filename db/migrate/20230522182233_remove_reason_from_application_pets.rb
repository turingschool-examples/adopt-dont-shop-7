class RemoveReasonFromApplicationPets < ActiveRecord::Migration[7.0]
  def change
    remove_column :application_pets, :reason, :string
  end
end

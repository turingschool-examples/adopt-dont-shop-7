class AddReasonToApplicationPets < ActiveRecord::Migration[7.0]
  def change
    add_column :application_pets, :reason, :string
  end
end

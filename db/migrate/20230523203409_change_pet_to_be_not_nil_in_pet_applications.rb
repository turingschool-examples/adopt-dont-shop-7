class ChangePetToBeNotNilInPetApplications < ActiveRecord::Migration[7.0]
  def change
    change_column :pet_applications, :pet_id, :integer, null: false
  end
end

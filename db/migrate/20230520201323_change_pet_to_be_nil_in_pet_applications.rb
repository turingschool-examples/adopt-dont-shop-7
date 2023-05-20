class ChangePetToBeNilInPetApplications < ActiveRecord::Migration[7.0]
  def change
    change_column_null :pet_applications, :pet_id, true
  end
end

class EditPetApplications < ActiveRecord::Migration[7.1]
  def change
    remove_column :pet_applications, :pets_id, :bigint
    remove_column :pet_applications, :applications_id, :bigint
    add_reference :pet_applications, :pet, foreign_key: true
    add_reference :pet_applications, :application, foreign_key: true
  end
end

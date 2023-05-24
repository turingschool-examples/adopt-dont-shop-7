class AddPetApplicationStatusToPetApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :pet_applications, :pet_applications_status, :string
  end
end

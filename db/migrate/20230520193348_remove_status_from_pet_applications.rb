class RemoveStatusFromPetApplications < ActiveRecord::Migration[7.0]
  def change
    remove_column :pet_applications, :status, :string
  end
end

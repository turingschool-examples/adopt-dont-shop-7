class AddPetAppStatusToPetApplications < ActiveRecord::Migration[7.1]
  def change
    add_column :pet_applications, :pet_app_status, :string, default: :Pending, null: false
  end
end

class AddAppStatusToPetApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :pet_applications, :app_status, :string, default: "pending"
  end
end

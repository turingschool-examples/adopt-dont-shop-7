class AddApplicationStatusToPetApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :pet_applications, :application_status, :string
  end
end

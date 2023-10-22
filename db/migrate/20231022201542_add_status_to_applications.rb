class AddStatusToApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :applications, :application_status, :string
  end
end

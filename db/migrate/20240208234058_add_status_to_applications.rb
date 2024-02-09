class AddStatusToApplications < ActiveRecord::Migration[7.1]
  def change
    add_column :applications, :status, :string
  end
end

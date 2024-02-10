class AddColumnToApplications < ActiveRecord::Migration[7.1]
  def change
    add_column :applications, :owner_endorsement, :string
    add_column :applications, :status, :string
  end
end

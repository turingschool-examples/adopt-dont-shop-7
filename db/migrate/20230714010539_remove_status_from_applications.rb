class RemoveStatusFromApplications < ActiveRecord::Migration[7.0]
  def change
    remove_column :applications, :status, :string
  end
end

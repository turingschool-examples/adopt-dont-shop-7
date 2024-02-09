class AddColumnsToApplications < ActiveRecord::Migration[7.1]
  def change
    add_column :applications, :city, :string
    add_column :applications, :state, :string
    add_column :applications, :zip_code, :string
  end
end

class AddColumnsToApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :applications, :city, :string
    add_column :applications, :state, :string
    add_column :applications, :zip_code, :integer
  end
end

class ChangeApplications < ActiveRecord::Migration[7.1]
  def change
    remove_column :applications, :full_address
    add_column :applications, :street_address, :string
    add_column :applications, :city, :string
    add_column :applications, :state, :string
    add_column :applications, :zip_code, :integer
  end
end

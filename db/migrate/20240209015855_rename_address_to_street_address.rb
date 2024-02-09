class RenameAddressToStreetAddress < ActiveRecord::Migration[7.1]
  def change
    rename_column :applications, :address, :street_address
  end
end

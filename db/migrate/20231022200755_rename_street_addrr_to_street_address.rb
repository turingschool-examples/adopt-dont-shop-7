class RenameStreetAddrrToStreetAddress < ActiveRecord::Migration[7.0]
  def change
    rename_column(:applications, :street_addr, :street_address)
  end
end

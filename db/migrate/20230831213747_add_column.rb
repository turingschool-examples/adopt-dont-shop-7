class AddColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :applicants, :address, :street_address
    add_column :applicants, :city, :string
    add_column :applicants, :state, :string
    add_column :applicants, :zip_code, :string
  end
end

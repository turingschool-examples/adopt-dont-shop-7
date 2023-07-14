class AddDetailsToApplicants < ActiveRecord::Migration[7.0]
  def change
    add_column :applicants, :street_address, :string
    add_column :applicants, :city, :string
    add_column :applicants, :state, :string
    add_column :applicants, :zip_code, :integer
  end
end

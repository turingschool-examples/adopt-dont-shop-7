class RemoveAddressFromApplicants < ActiveRecord::Migration[7.0]
  def change
    remove_column :applicants, :address, :string
  end
end

class AddNewAttributeToApplicants < ActiveRecord::Migration[7.0]
  def change
    add_column :applicants, :pets, :string
  end
end

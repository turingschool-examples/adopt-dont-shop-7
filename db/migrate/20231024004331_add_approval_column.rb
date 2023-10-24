class AddApprovalColumn < ActiveRecord::Migration[7.0]
  def change
    add_column :pet_applications, :adoption_approved, :boolean 
  end
end

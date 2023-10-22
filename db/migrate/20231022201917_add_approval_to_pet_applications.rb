class AddApprovalToPetApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :pet_applications, :approvals, :string
  end
end

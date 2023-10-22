class ChangeApprovalsToStatus < ActiveRecord::Migration[7.0]
  def change
    rename_column :pet_applications, :approvals, :status
  end
end

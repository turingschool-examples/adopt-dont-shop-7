class AddGoodOwnerReasonToApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :applications, :good_owner_reason, :string
  end
end

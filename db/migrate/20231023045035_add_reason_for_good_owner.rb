class AddReasonForGoodOwner < ActiveRecord::Migration[7.0]
  def change
    add_column :applications, :reason_for_good_owner, :string
  end
end

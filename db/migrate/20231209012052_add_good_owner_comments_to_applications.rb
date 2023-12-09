class AddGoodOwnerCommentsToApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :applications, :good_owner_comments, :string
  end
end

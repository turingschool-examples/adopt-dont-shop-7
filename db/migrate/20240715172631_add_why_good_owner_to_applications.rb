class AddWhyGoodOwnerToApplications < ActiveRecord::Migration[7.1]
  def change
    add_column :applications, :why_good_owner, :string
  end
end

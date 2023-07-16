class AddDescriptionOwnerToApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :applications, :description_owner, :string
  end
end

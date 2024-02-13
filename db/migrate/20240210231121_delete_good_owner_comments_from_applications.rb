class DeleteGoodOwnerCommentsFromApplications < ActiveRecord::Migration[7.0]
  def change
    remove_column :applications, :good_owner_comments, :string
    add_column :application_pets, :good_owner_comments, :string
  end
end

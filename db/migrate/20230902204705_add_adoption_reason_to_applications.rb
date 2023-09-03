class AddAdoptionReasonToApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :applications, :adoption_reason, :string
  end
end

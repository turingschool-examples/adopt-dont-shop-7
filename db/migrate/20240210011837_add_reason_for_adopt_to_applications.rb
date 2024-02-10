class AddReasonForAdoptToApplications < ActiveRecord::Migration[7.1]
  def change
    add_column :applications, :reason_for_adoption, :string
  end
end

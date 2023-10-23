class AddQualificationsToApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :applications, :qualifications, :string
  end
end

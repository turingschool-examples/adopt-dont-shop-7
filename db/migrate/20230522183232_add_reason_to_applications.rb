class AddReasonToApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :applications, :reason, :string
  end
end

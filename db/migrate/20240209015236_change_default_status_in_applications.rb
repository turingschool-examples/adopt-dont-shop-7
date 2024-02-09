class ChangeDefaultStatusInApplications < ActiveRecord::Migration[7.1]
  def change
    change_column_default :applications, :status, from: nil, to: 'In Progress'
  end
end

class UpdateDefaultStatus < ActiveRecord::Migration[7.0]
  def change
    change_column :applications, :status, :string, default: "In Progress"
  end
end

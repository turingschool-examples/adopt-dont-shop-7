class UpdateDefaultStatus < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:applications, :status, "In Progress")
  end
end

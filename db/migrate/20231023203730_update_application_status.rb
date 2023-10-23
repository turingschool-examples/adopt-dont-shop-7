class UpdateApplicationStatus < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:applications, :status, 0)
  end
end

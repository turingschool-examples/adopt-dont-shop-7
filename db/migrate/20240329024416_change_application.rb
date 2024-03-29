class ChangeApplication < ActiveRecord::Migration[7.1]
  def change
    remove_column :applications, :status, :string
    add_column :applications, :status, :string , :null => false, :default => "In Progress"
  end
end

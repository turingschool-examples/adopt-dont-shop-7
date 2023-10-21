class AddColumnToApplication < ActiveRecord::Migration[7.0]
  def change
    add_column :applications, :good_owner, :string
    rename_column :applications, :description, :good_home
  end
end

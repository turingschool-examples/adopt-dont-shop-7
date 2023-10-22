class RenameZipToZipCode < ActiveRecord::Migration[7.0]
  def change
    rename_column :applications, :zip, :zip_code
  end
end

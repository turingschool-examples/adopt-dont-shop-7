class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :full_address
      t.string :description
      t.integer :status

      t.timestamps
    end
  end
end

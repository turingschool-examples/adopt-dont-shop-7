class CreateApps < ActiveRecord::Migration[7.0]
  def change
    create_table :apps do |t|
      t.string :name
      t.string :address
      t.string :city
      t.integer :zip
      t.string :description

      t.timestamps
    end
    add_column :apps, :status, :integer, default: 0
  end
end

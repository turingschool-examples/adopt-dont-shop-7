class CreateApps < ActiveRecord::Migration[7.0]
  def change
    create_table :apps do |t|
      t.string :name
      t.string :address
      t.string :city
      t.integer :zip
      t.string :description
      t.string :status

      t.timestamps
    end
  end
end

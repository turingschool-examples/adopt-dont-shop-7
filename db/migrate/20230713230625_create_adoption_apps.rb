class CreateAdoptionApps < ActiveRecord::Migration[7.0]
  def change
    create_table :adoption_apps do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :description
      t.string :pet_names
      t.string :status

      t.timestamps
    end
  end
end

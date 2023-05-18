class CreatePetsApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :pets_applications do |t|
      t.integer :pet_id
      t.string :pet_status
      t.references :application, null: false, foreign_key: true

      t.timestamps
    end
  end
end

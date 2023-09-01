class CreatePetsApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :pets_applications do |t|
      t.references :pets, foreign_key: true
      t.references :applicants, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :applications do |t|
      t.string :applicant_name
      t.string :full_address
      t.string :description
      t.references :pet, null: false, foreign_key: true
      # break the direct link here 
      t.string :application_status

      t.timestamps
    end
  end
end

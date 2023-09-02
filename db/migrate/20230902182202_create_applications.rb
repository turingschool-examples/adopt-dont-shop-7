class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :applications do |t|
      t.string :applicant_name
      t.string :address
      t.string :description
      t.string :pet_names
      t.string :status

      t.timestamps
    end
  end
end

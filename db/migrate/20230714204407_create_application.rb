class CreateApplication < ActiveRecord::Migration[7.0]
  def change
    create_table :applications do |t|
      t.string :name_of_applicant
      t.string :street_address
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :description
      t.string :application_status

      t.timestamps
    end
  end
end

class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :application do |t|
      t.string :applicant_name
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :description
      t.string :application_status, default: "In Progress"

      t.timestamps
    end
  end
end

class CreateApplicants < ActiveRecord::Migration[7.0]
  def change
    create_table :applicants do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :description
      t.string :status, default: "In Progress"

      t.timestamps
    end
  end
end

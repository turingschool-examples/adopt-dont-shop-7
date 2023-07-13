class CreatePetsApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :pets_applications do |t|

      t.timestamps
    end
  end
end

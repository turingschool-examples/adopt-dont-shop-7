class AddStatusToPetApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :pet_applications, :status, :integer, :default => 0
  end
end

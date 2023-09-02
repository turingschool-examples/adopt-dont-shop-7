class AddColumnToPetsApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :pets_applications, :status, :string, :default => "In Progress"
  end
end

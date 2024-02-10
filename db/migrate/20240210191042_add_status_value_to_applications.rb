class AddStatusValueToApplications < ActiveRecord::Migration[7.1]
  def change
    change_column(:applications, :status, :string, :default => "In Progress")
  end
end

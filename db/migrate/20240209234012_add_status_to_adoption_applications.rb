class AddStatusToAdoptionApplications < ActiveRecord::Migration[7.1]
  def change
    add_column :adoption_applications, :status, :string, default: 'In Progress'
  end
end

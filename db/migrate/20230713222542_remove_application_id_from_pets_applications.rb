class RemoveApplicationIdFromPetsApplications < ActiveRecord::Migration[7.0]
  def change
    remove_column :pets_applications, :application_id, :integer
  end
end

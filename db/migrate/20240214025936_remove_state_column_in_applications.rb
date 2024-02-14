class RemoveStateColumnInApplications < ActiveRecord::Migration[7.1]
  def change
    remove_column :applications, :state, :string
  end
end

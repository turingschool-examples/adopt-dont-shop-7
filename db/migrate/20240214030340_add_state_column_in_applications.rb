class AddStateColumnInApplications < ActiveRecord::Migration[7.1]
  def change
    add_column :applications, :state, :string
  end
end

class AddRejectedToPets < ActiveRecord::Migration[7.0]
  def change
    add_column :pets, :rejected, :boolean
  end
end

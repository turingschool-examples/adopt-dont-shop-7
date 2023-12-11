class AddApplicationsToPets < ActiveRecord::Migration[7.0]
  def change
    add_reference :pets, :application, foreign_key: true
  end
end

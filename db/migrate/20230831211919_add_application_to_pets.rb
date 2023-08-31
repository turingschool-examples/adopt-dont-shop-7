class AddApplicationToPets < ActiveRecord::Migration[7.0]
  def change
    add_reference :pets, :application, null: true, foreign_key: true
  end
end

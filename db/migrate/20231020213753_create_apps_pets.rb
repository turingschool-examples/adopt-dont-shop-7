class CreateAppsPets < ActiveRecord::Migration[7.0]
  def change
    create_table :apps_pets do |t|
      t.references :app, null: false, foreign_key: true
      t.references :pet, null: false, foreign_key: true

      t.timestamps
    end
  end
end

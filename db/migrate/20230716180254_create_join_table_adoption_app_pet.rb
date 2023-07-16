class CreateJoinTableAdoptionAppPet < ActiveRecord::Migration[7.0]
  def change
    create_join_table :adoption_apps, :pets do |t|
      # t.index [:adoption_app_id, :pet_id]
      # t.index [:pet_id, :adoption_app_id]
    end
  end
end

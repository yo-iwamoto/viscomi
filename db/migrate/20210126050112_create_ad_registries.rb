class CreateAdRegistries < ActiveRecord::Migration[6.0]
  def change
    create_table :ad_registries do |t|
      t.references :ad,                      null: false, foreign_key: true
      t.references :community_center,        null: false, foreign_key: true

      t.timestamps
    end
  end
end

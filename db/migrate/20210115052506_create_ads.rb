class CreateAds < ActiveRecord::Migration[6.0]
  def change
    create_table :ads do |t|
      t.string :owner
      t.references :community_center, null: false, foreign_key: true

      t.timestamps
    end
  end
end

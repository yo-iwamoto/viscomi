class CreateCommunityCetnerImages < ActiveRecord::Migration[6.0]
  def change
    create_table :community_cetner_images do |t|
      t.references :community_center, null: false, foreign_key: true

      t.timestamps
    end
  end
end
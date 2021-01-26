class CreateAdImages < ActiveRecord::Migration[6.0]
  def change
    create_table :ad_images do |t|
      t.text       :image
      t.references :ad, null: false, foreign_key: true

      t.timestamps
    end
  end
end

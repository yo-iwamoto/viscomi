class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :type, null: false, default: ''
      t.string :title
      t.string :content
      t.references :community_center, null: false, foreign_key: true

      t.timestamps
    end
  end
end

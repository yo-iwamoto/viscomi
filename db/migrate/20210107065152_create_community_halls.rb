class CreateCommunityHalls < ActiveRecord::Migration[6.0]
  def change
    create_table :community_halls do |t|
      t.string :name

      t.timestamps
    end
  end
end

class AddCommentToCommunityCenters < ActiveRecord::Migration[6.0]
  def change
    add_column :community_centers, :comment, :string
  end
end

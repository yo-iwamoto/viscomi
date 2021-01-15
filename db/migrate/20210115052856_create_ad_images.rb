class CreateAdImages < ActiveRecord::Migration[6.0]
  def change
    create_table :ad_images do |t|

      t.timestamps
    end
  end
end

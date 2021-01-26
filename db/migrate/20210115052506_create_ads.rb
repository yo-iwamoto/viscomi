class CreateAds < ActiveRecord::Migration[6.0]
  def change
    create_table :ads do |t|
      t.string     :owner_name,       null: false
      t.text       :content
      t.string     :phone_number
      t.string     :url

      t.timestamps
    end
  end
end

class CreateContactImages < ActiveRecord::Migration[6.0]
  def change
    create_table :contact_images do |t|
      t.text       :image
      t.references :contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end

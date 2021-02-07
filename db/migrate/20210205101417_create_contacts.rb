class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.references :community_center, null: false, foreign_key: true
      t.string     :subject,        null: false
      t.text       :content,        null: false
      t.boolean    :now_processing, null: false, default: false
      t.datetime   :sent_at,        default: nil

      t.timestamps
    end
  end
end

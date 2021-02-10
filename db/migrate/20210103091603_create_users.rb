class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string   :name,                  null: false, default: ""
      t.string   :email,                 null: false, default: "", index: { unique: true }
      t.string   :password_digest
      t.string   :activation_digest
      t.boolean  :activated,             null: false, default: false
      t.string   :reset_digest
      t.datetime :reset_sent_at
      t.boolean  :mute_contact,     null: false, default: false

      t.timestamps
    end
  end
end
class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string  :name,                  null: false, default: ""
      t.string  :email,                 null: false, default: "", index: { unique: true }
      t.string  :password_digest
      t.string  :remember_digest
      t.string  :activation_digest
      t.string  :authentication_digest
      t.boolean :activated,             default: false

      t.timestamps
    end
  end
end
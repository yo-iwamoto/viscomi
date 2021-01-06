class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, null: false, default: ""
      t.string :email, null: false, unique: true, default: ""

      t.timestamps
    end
  end
end

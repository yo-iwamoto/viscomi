class AddAuthenticationDigestToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :authentication_digest, :string
  end
end

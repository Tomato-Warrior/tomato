class AddAuthTokenOnUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :auth_token, :string
    add_index :users, :auth_token, unique: true

    # 舊user產生auth_token
    User.all.each do |user|
      user.regenerate_auth_token
    end
  end

end
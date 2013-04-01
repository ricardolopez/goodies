class FixPasswordColumnName < ActiveRecord::Migration
  def up
  	rename_column :users, :hashed_password, :password_hash
  end

  def down
  end
end

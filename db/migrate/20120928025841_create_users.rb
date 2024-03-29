class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end

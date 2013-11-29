class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.integer :type
      t.string :name
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end

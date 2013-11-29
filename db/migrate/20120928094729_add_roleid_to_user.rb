class AddRoleidToUser < ActiveRecord::Migration
  def change
    add_column :users, :roleid, :string
  end
end

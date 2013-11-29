class CreateSpBusinesses < ActiveRecord::Migration
  def change
    create_table :sp_businesses do |t|

      t.timestamps
    end
  end
end

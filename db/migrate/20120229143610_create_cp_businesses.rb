class CreateCpBusinesses < ActiveRecord::Migration
  def change
    create_table :cp_businesses do |t|

      t.timestamps
    end
  end
end

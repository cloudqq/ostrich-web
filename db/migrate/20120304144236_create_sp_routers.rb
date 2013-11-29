class CreateSpRouters < ActiveRecord::Migration
  def change
    create_table :sp_routers do |t|

      t.timestamps
    end
  end
end

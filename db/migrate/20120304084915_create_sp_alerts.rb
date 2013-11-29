class CreateSpAlerts < ActiveRecord::Migration
  def change
    create_table :sp_alerts do |t|

      t.timestamps
    end
  end
end

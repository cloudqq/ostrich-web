class CreateMrLogs < ActiveRecord::Migration
  def change
    create_table :mr_logs do |t|

      t.timestamps
    end
  end
end

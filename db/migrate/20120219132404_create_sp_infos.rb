class CreateSpInfos < ActiveRecord::Migration
  def change
    create_table :sp_infos do |t|

      t.timestamps
    end
  end
end

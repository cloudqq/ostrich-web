class CreateCpInfos < ActiveRecord::Migration
  def change
    create_table :cp_infos do |t|

      t.timestamps
    end
  end
end

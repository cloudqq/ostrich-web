class CreateSerials < ActiveRecord::Migration
  def change
    create_table :SERIALS do |t|
      t.string :CODE, null:false
      t.integer :MAXNO, default: 0
      t.integer :LENGTH, default: 2
      t.timestamps
    end
  end
end

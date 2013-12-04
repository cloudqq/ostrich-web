class AddSpnumberPriceToCpbusiness < ActiveRecord::Migration
  def change
    add_column :CP_BUSINESS, :SPNUMBER, :string, :limit => 25
    add_column :CP_BUSINESS, :PRICE, :integer
  end
end

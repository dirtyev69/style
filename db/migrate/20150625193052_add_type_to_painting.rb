class AddTypeToPainting < ActiveRecord::Migration
  def self.up
    add_column :paintings, :item_type, :integer
  end

  def self.down
    remove_column :paintings, :item_type
  end
end

class NewBookSpec < ActiveRecord::Migration
  def self.up
    add_column :books, :isbn, :integer
  end

  def self.down
    remove_column :books, :isbn
  end
end

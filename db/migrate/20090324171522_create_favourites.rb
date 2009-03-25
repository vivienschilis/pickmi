class CreateFavourites < ActiveRecord::Migration
  def self.up
    create_table :favourites do |t|
      t.integer :book_id, :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :favourites
  end
end

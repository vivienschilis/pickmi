class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :title, :subtitle, :photo, :edition, :summary, :author, :editor
      t.float :price
      t.date :publish_at
      t.integer :pages, :isbn
      t.string :pick_url
      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end

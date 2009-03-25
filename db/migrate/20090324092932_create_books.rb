class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :title
      t.float :price
      t.string :photo
      t.string :edition
      t.string :summary
      t.string :author
      t.date :publish_at

      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end

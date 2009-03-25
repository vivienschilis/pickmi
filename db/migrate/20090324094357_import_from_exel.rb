require 'fastercsv'

class ImportFromExel < ActiveRecord::Migration
  def self.up
    
    excel_file = 'db/data/books.csv'

    #for each line we create a new book entry
    FasterCSV.foreach(excel_file,  :col_sep => ";", :row_sep => "\r") do |row|
      Book.create(:price => row[0], :photo => row[2], :title => row[4], :edition => row[6], 
                  :author => row[8], :publish_at => row[10], :summary => row[18])
    end
    
  end

  def self.down
  end
end

require 'fastercsv'
require 'htmlentities'

class ImportFromExel < ActiveRecord::Migration
  def self.up

     csv_file = 'db/data/books.csv'
     #for each line we create a new book entry
     coder = HTMLEntities.new

        FasterCSV.foreach(csv_file, :col_sep => ";"  , :row_sep => "\r") do |row|
       Book.create(:isbn => row[2].split('/').last.split('.').first.chop , :photo => row[2], :title => coder.decode(row[4]), :editor => row[6], 
                   :author => row[8], :edition => row[10], :summary => coder.decode(row[18]))
       
    #FasterCSV.foreach(csv_file, :headers => true, :col_sep => ",") do |row|

       
#	Book.create(:title => coder.decode(row[4]), :subtitle => row[5], :author => row[6], 
 #                       :edition => row[7], :editor => row[8], :pages => row[10], :isbn => row[14])	
     end
  end

  def self.down
  end
end

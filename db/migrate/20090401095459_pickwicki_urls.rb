require 'fastercsv'


# tr -d '\n' <  pickurls.csv > pickurls_new.csv

class PickwickiUrls < ActiveRecord::Migration
  def self.up
    cvs_file = 'db/data/pickurls.csv'
          
    File.open(cvs_file).each { |line| 
      
      isbn = line.split(',').last.chop
      url = line.split(',').first

      unless isbn == ''
        book = Book.find_by_isbn(isbn)
        unless book.nil?
          book.pick_url = url
          book.save
        end
      end
      
    }
  end

  def self.down
  end
end

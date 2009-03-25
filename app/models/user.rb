class User < ActiveRecord::Base
  has_many :favourites, :dependent => :destroy
  has_many :books, :through => :favourites 
  
end

class Book < ActiveRecord::Base
  has_many :favourites, :dependent => :destroy
  has_many :users, :through => :favourites
  
end

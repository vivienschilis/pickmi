class Book < ActiveRecord::Base
  has_many :favourites, :dependent => :destroy
  has_many :users, :through => :favourites
  has_many :videos, :dependent => :destroy
  
end

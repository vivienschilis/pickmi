class Book < ActiveRecord::Base
  has_many :favourites, :dependent => :destroy
  has_many :users, :through => :favourites
  
  
  def self.search (search, page)
     paginate  :per_page => 10, :page => page,
                            :conditions => ['title like ? OR author like ?', "%#{search}%", "%#{search}%"],
                            :order => :title
  end
  
  def is_a_favourite?(user)
    self.users.include?(user)
  end
  
  
  def self.top_five
    Book.find(:all, :joins => :favourites, :select => '*, COUNT(*) as popularity ', 
                    :group => :book_id , :order => 'popularity DESC', :limit => 5)
  end
end
  
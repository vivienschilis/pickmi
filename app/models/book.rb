class Book < ActiveRecord::Base
  has_many :favourites, :dependent => :destroy
  has_many :users, :through => :favourites
  
  validates_uniqueness_of :isbn
  
  
  def self.search (search, page)

    if (page.nil? || page.empty? || page.to_i < 1 ) 
      page = 1
    end
      
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
  
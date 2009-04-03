require 'net/http'
require 'uri'

class Book < ActiveRecord::Base
  has_many :favourites, :dependent => :destroy
  has_many :users, :through => :favourites
  
  #validates_uniqueness_of :isbn , :if => Proc.new {|f| not f.nil?}
  
  
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

  def photo_s3
	#url ="http://altomicvideo.s3.amazonaws.com/pickwiki_" + isbn.to_s + ".jpg"
	#unless photo.empty?
		photo
	#else 
	#		if Net::HTTP.get_response(URI.parse(url)) == Net::HTTPSuccess 
	#	url
	#else
	# 	"images/default_pic"
	#end
	#end
  end
end
  

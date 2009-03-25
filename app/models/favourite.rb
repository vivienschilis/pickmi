class Favourite < ActiveRecord::Base
   belongs_to :user
   belongs_to :book

   validates_uniqueness_of :user_id, :scope => :book_id

   def before_save
     if Favourite.find_all_by_user_id(self.user_id).length >= 5
       false
      end
   end
   
end

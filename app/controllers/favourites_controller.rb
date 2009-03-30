class FavouritesController < ApplicationController

 def index  
   @books = @user.books
   
   respond_to do |format|
     format.html # index.html.erb
     format.fbml # index.fbml.erb
   end
 end
end
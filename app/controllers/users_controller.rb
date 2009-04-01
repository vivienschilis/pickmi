class UsersController < ApplicationController

 def index  
   #@users = facebook_session.user.friends

   respond_to do |format|
     format.html # index.html.erb
     format.fbml # index.fbml.erb
   end
 end

end
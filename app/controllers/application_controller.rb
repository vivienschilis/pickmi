# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
    
  protect_from_forgery :except => [:auto_complete_for_book_title, :select_remote, :describe]
  # :secret => '051a8150465afe2e29497df7a17e20da'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  before_filter :ensure_application_is_installed_by_facebook_user
  before_filter :ensure_authenticated_to_facebook
  
  before_filter :get_facebook_user
  before_filter :get_facebook_friends
  
  def get_facebook_user
    @facebook_user = facebook_session.user
    @user = User.find_or_create_by_facebook_id(@facebook_user.uid)
  end
  
  def get_facebook_friends
    @facebook_friends = facebook_session.user.friends_with_this_app
    #@facebook_friends = [] << facebook_session.user
  end

end

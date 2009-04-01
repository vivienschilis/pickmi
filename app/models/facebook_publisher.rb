class FacebookPublisher < Facebooker::Rails::Publisher
  
  def book_choosen_notification(user) 
    send_as :notification 
    victim = Facebooker::User.new(user.uid)
    attacker = Facebooker::User.new(user.uid)
    # Note this only works during a request cycle 
    # since the session is being held for us 
    self.recipients(victim) 
    self.from(attacker) 
    fbml "has choosen his 5 favourite books. #{link_to('Choose yours' , root_url) } "
  end

  def book_choosen_feed_template
    
    one_line_story_template("{*actor*} ha publicato i sui cinque libri favoriti")

    short_story_template("{*actor*} ha publicato i sui cinque libri favoriti",
                          "Qui i cinque libri ")

    full_story_template("{*actor*} ha publicato i sui cinque libri favoriti",
                          "Qui i cinque libri ")

  end 
  
  def book_choosen_feed(user) 
    fb_user = User.find_by_facebook_id(user.uid)
    
    victim = Facebooker::User.new(user.uid) 
    attacker = Facebooker::User.new(user.uid) 
    send_as :user_action 
    from attacker
    data :images => [ image(fb_user.books.first.photo, root_url) ]

    
  end
  
end

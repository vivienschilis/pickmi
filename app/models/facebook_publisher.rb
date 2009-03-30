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
    one_line_story_template("{*actor*} ha publicato i sui cinque libri favoriti 2")

    short_story_template("{*actor*} ha publicato i sui cinque libri favoriti",
                      "1")
  
    full_story_template("{*actor*} ha publicato i sui cinque libri favoriti",
                      "2")

#    full_story_template("{*actor*} ha publicato i sui cinque libri favoriti",
 #                     "1{*image_0*}2{*image_1*}3{*image_2*}4{*image_3*}5{*image_4*}")

  end 
  
  def book_choosen_feed(user) 
    fb_user = User.find_by_facebook_id(user.uid)
    
    victim = Facebooker::User.new(user.uid) 
    attacker = Facebooker::User.new(user.uid) 
    send_as :user_action 
    story_size SHORT
    from attacker
    data({ 
      :images => [{:href => "http://www.google.fr/intl/fr_fr/images/logo.gif" }]  
    })
    # :image_0 => image_tag (fb_user.books[0].photo, :width => '15'),
    #       :image_1 => image_tag (fb_user.books[1].photo, :width => '15'),
    #       :image_2 => image_tag (fb_user.books[2].photo, :width => '15'),
    #       :image_3 => image_tag (fb_user.books[3].photo, :width => '15'),
    #       :image_4 => image_tag (fb_user.books[4].photo, :width => '15')
    #
  end
  
end

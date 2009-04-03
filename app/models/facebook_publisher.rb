class FacebookPublisher < Facebooker::Rails::Publisher
  
  def book_choosen_notification(user) 
    send_as :notification 
    #victim = Facebooker::User.new(user.uid)
    #attacker = Facebooker::User.new(user.uid)
    # Note this only works during a request cycle 
    # since the session is being held for us 
    #self.recipients(victim) 
    from user
    fbml "has choosen his 5 favourite books. #{link_to('Choose yours' , root_url) } "

  end

  def book_choosen_feed_template
    
    one_line_story_template("{*actor*} ha publicato i sui cinque libri favoriti")

    short_story_template("{*actor*} ha publicato i sui cinque libri favoriti","<p>Puoi sceliere anche i tui libri su PickWicki.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa</p>" )

    full_story_template("{*actor*} ha publicato i sui cinque libri favoriti", "<p>Puoi sceliere anche i tui libri su PickWicki aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa.</p>" )

    #action_links action_link("Visit {*template_var*}","{*link_url*}")
  end 
  
  def book_choosen_feed(user) 
    fb_user = User.find_by_facebook_id(user.uid);
    send_as :user_action 
    from user
    data {:images => [ image(fb_user.books.first.photo, root_url) ] }

#	data({:pickwicki_link => link_to("PickWicki", root_url) ,
#        :image_link => link_to(image_tag(fb_user.books.first.photo), book_url),
#        :call_to_action => "Check out#{link_to("your favourite books", root_url ) } "  })
  end
  
end

class BooksController < ApplicationController
 # auto_complete_for :book, :title

  # GET /books
  # GET /books.xml
  before_filter :get_top_five_books
  before_filter :get_friends_books
  
  def get_top_five_books
    @top_five = Book.top_five
  end
  
  def get_friends_books
    start = rand(@facebook_friends.size-5)
    start = 0
    @random_friends_using_app = []
    @facebook_friends[start..(start+5)].each do |friend|
      @random_friends_using_app <<  User.find_by_facebook_id(friend.uid)
    end
  end
  
  def index

    @books = Book.search ( params['search'], params['page'])
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @books }
      format.fbml 

    end
  end

  # GET /books/1
  # GET /books/1.xml
  def show
    @book = Book.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @book }
      format.fbml 
      
    end
  end

  # GET /books/new
  # GET /books/new.xml
  # def new
  #   @book = Book.new
  # 
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.xml  { render :xml => @book }
  #     format.fbml 
  #     
  #   end
  # end

  # GET /books/1/edit
  # def edit
  #    @book = Book.find(params[:id])
  #  end

  # POST /books
  # POST /books.xml
  # def create
  #   @book = Book.new(params[:book])
  # 
  #   respond_to do |format|
  #     if @book.save
  #       flash[:notice] = 'Book was successfully created.'
  #       format.html { redirect_to(@book) }
  #       format.xml  { render :xml => @book, :status => :created, :location => @book }
  #     else
  #       format.html { render :action => "new" }
  #       format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  # PUT /books/1
  # PUT /books/1.xml
  # def update
  #   @book = Book.find(params[:id])
  # 
  #   respond_to do |format|
  #     if @book.update_attributes(params[:book])
  #       flash[:notice] = 'Book was successfully updated.'
  #       format.html { redirect_to(@book) }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /books/1
  # DELETE /books/1.xml
  # def destroy
  #   @book = Book.find(params[:id])
  #   @book.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to(books_url) }
  #     format.xml  { head :ok }
  #   end
  # end
  

  def select

    @book = Book.find(params[:id])

    # More than 5 books
    if @user.books.size >= 5
      flash[:notice] = "You can't choose more than 5 books!"
      redirect_to(books_url)
    else
      @favourite = Favourite.new(:book => @book, :user => @user)
      respond_to do |format|
        if @favourite.save
          
          #propose to publish your 5 books
          if @user.books.size == 5
            flash[:should_publish] = true
          end
                    
          format.fbml { redirect_to(books_url) }
        else
          flash[:notice] = 'Sorry, An error occured!'
          format.fbml { redirect_to(books_url) }
        end
      end
    end
  end
  
  def select_remote
     @book = Book.find(params[:id])
     @favourite = Favourite.new(:book => @book, :user => @user)
     render :text => "Text succeed"
     
  end
  
  # def unselect
  #   @book = Book.find(params[:id])
  #   @favourite = Favourite.find_by_book_id_and_user_id(@book,@user)
  #   @favourite.destroy
  #   
  #   respond_to do |format|
  #     format.fbml { redirect_to(books_url) }
  #   end
  # end
  # 
  # def unselect_remote
  #   @book = Book.find(params[:id])
  #   @favourite = Favourite.find_by_book_id_and_user_id(@book,@user)
  #   @favourite.destroy
  #   render :partial => "/favourite/profile_table"
  # end
  # 
  # 
  # def auto_complete_for_book_title
  #   titles = Book.find(:all,
  #     :conditions => [ 'LOWER(title) LIKE ?', params[:suggest_typed].downcase + '%'],
  #     :order => 'thing ASC',
  #     :limit => 10).map { |n| n.title }
  #   render :text => "{fortext:#{params[:suggest_typed].to_json},results:#{titles.to_json}}"
  # end

  def publish

    if @user.books.size >= 5
 #     FacebookPublisher.deliver_book_choosen_notification(facebook_session.user)
      FacebookPublisher.deliver_book_choosen_feed(facebook_session.user)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @book }
      format.fbml { redirect_to(books_url) }
    end


  end
  
  
end

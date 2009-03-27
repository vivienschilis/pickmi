class BooksController < ApplicationController
 auto_complete_for :book, :title

  # GET /books
  # GET /books.xml
  def index
    @books = Book.paginate  :per_page => 10, :page => params['page'],
                            :order => :title
    
    start = rand(@facebook_friends.size-5)
    start = 0
    @random_friends_using_app = []
    @facebook_friends[start..(start+5)].each do |friend|
      @random_friends_using_app <<  User.find_by_facebook_id(friend.uid)
    end
    
 #   @top_five = Favourite.find(:all, :select => 'book_id, COUNT(*) as popularity ', :group => :book_id , :order => 'popularity DESC', :limit => 5)
    @top_five = Book.find(:all, :joins => :favourites, :select => '*,   COUNT(*) as popularity ', :group => :book_id , :order => 'popularity DESC', :limit => 5)

    # start = rand(@facebook_friends.size-5)
    #    facebook_session.users[start..(start+5)].each do |user|
    #      @random_user_using_app <<  User.find_by_facebook_id(friend.uid)
    #    end
    
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
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @book }
      format.fbml 
      
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.xml
  def create
    @book = Book.new(params[:book])

    respond_to do |format|
      if @book.save
        flash[:notice] = 'Book was successfully created.'
        format.html { redirect_to(@book) }
        format.xml  { render :xml => @book, :status => :created, :location => @book }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.xml
  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        flash[:notice] = 'Book was successfully updated.'
        format.html { redirect_to(@book) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.xml
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to(books_url) }
      format.xml  { head :ok }
    end
  end
  
  
  def select
    
    logger.info("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
    @book = Book.find(params[:id])
    @favourite = Favourite.new(:book => @book, :user => @user)
    
    respond_to do |format|
      if @favourite.save
        flash[:notice] = 'Book was successfully selected.'
        format.fbml { redirect_to(books_url) }
      else
        format.fbml { render :action => "new" }
      end
    end
  end
  
  def select_remote
     logger.info("tessstttttttttttttttttttttttttttt")
     @book = Book.find(params[:id])
     @favourite = Favourite.new(:book => @book, :user => @user)
     render :text => "Text succeed"
     
  end
  
  def unselect
    @book = Book.find(params[:id])
    @favourite = Favourite.find_by_book_id_and_user_id(@book,@user)
    @favourite.destroy
    
    respond_to do |format|
      flash[:notice] = 'Book was successfully unselected.'
      format.fbml { redirect_to(favourites_url) }
    end
  end

  def unselect_remote
    @book = Book.find(params[:id])
    @favourite = Favourite.find_by_book_id_and_user_id(@book,@user)
    @favourite.destroy
    render :partial => "/favourite/profile_table"
  end

  def auto_complete_for_book_title
    logger.info("tessstttttttttttttttttttttttttttt")
    titles = Book.find(:all,
      :conditions => [ 'LOWER(title) LIKE ?', params[:suggest_typed].downcase + '%'],
      :order => 'thing ASC',
      :limit => 10).map { |n| n.title }
    render :text => "{fortext:#{params[:suggest_typed].to_json},results:#{titles.to_json}}"
  end
  
end

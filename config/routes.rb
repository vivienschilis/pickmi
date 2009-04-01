ActionController::Routing::Routes.draw do |map|

  map.root    :controller => "books"


  map.connect '/books/auto_complete_for_book_title', :controller=>"books", :action=>"auto_complete_for_book_title"
  map.select_remote_books '/books/select_remote', :controller=>"books", :action=>"select_remote"
  map.describe_books '/books/:id/describe' , :controller=>"books", :action=>"describe"
  map.publish_books '/books/publish', :controller=>"books", :action=>"publish"

#  map.unselect_book '/books/:id/unselect_book', :controller=>"books", :action=>"unselect"
#  map.select_book '/books/:id/select_book', :controller=>"books", :action=>"select"

  map.books '/books', :controller=>"books", :action=>"index"
  map.book '/books/:id', :controller=>"books", :action=>"show"
  map.formatted_book '/books/:id.:format', :controller=>"books", :action=>"show"

    
  map.resources :favourites
  map.resources :users 


  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

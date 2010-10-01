ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users, :member => { :promote => :put, :demote => :put }
  map.resource :session
  map.resources :posts, :collection => { :search => :get } do |post|
    post.resources :cheers, :only => [:create, :destroy]
  end
  map.resources :replies
  map.root :controller => 'posts', :action => 'index'
end

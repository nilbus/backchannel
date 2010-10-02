require 'spec_helper'

describe PostsController do
  include AuthenticatedTestHelper
  include AuthenticatedSystem

  fixtures :all

  before do
    login_as nil
  end

  describe "GET 'index'" do
    it "should be successful when not logged in" do
      get 'index'
      response.should be_success
    end

    it 'should show newest posts first' do
      Post.stub!(:roots)
      Post.roots.stub!(:newest_first).and_return(mock_model(Post))
      Post.roots.newest_first.stub!(:with_cheers).and_return(mock_model(Post))
      Post.roots.newest_first.should_receive(:with_cheers)
      get 'index'
    end

    it 'should provide a list of users sorted by most cheers received' do
      User.stub!(:by_cheers)
      User.should_receive(:by_cheers)
      get 'index'
    end
  end

  describe "GET 'search'" do
    it "should show search results" do
      get 'search', :search => 'this'
      response.should be_success
      assigns[:posts].size.should eql(2)
      assigns[:posts].each do |post|
        post.content.grep(/this/i).size.should eql(1)
      end
    end
  end

  describe "POST 'create'" do
    it "should not be able to post without logging in" do
      post 'create', :post => {:content => 'hey cool man'}
      response.should be_redirect
      Post.count.should eql(4)
    end

    it "should be able to post when logged in" do
      login_as :nilbus
      post 'create', :post => {:content => 'hey cool man'}
      response.should be_redirect
      Post.count.should eql(5)
    end
  end

  describe "DELETE 'destroy'" do
    it "should not be able to delete without logging in" do
      delete 'destroy', :id => posts(:nilbus_welcome)
      response.should be_redirect
      Post.count.should eql(4)
    end

    it "should not be able to delete without admin permissions" do
      login_as :nilbus
      delete 'destroy', :id => posts(:nilbus_welcome)
      response.should be_redirect
      Post.count.should eql(4)
    end

    it "should be able to delete as an admin" do
      login_as :admin
      delete 'destroy', :id => posts(:nilbus_welcome)
      response.should be_redirect
      Post.count.should eql(2)
    end
  end
end

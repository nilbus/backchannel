require 'spec_helper'

describe CheersController do
  include AuthenticatedTestHelper
  include AuthenticatedSystem

  fixtures :all

  before do
    login_as :nilbus
  end

  describe "POST 'create'" do
    it "should do nothing when not logged in" do
      login_as nil
      post 'create', :post_id => posts(:nilbus_welcome).id
      response.should be_success
      response.content_type.should eql('text/javascript')
      Cheer.count.should eql(3)
    end

    it 'should cheer a previously uncheered post' do
      post 'create', :post_id => posts(:admin_mine).id
      response.should be_success
      Cheer.count.should eql(4)
    end

    it 'should not cheer a previously cheered post' do
      post 'create', :post_id => posts(:vino_hi).id
      response.should be_success
      Cheer.count.should eql(3)
    end

    it 'should not cheer your own post' do
      post 'create', :post_id => posts(:nilbus_welcome).id
      response.should be_success
      Cheer.count.should eql(3)
    end
  end

  describe "DELETE 'destroy'" do
    it "should do nothing when not logged in" do
      login_as nil
      delete 'destroy', :post_id => posts(:nilbus_welcome).id, :id => :destroy
      response.should be_success
      response.content_type.should eql('text/javascript')
      Cheer.count.should eql(3)
    end

    it 'should uncheer a previously cheered post' do
      delete 'destroy', :post_id => posts(:vino_hi).id, :id => :destroy
      response.should be_success
      Cheer.count.should eql(2)
    end

    it 'should not uncheer a post you have not cheered' do
      delete 'destroy', :post_id => posts(:nilbus_welcome).id, :id => :destroy
      response.should be_success
      Cheer.count.should eql(3)
    end
  end
end

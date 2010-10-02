require 'spec_helper'

describe Post do
  fixtures :all

  before(:each) do
    @valid_attributes = {
      :content => 'value for content',
      :user_id => users(:nilbus).id
    }
  end

  it 'should create a new instance given valid attributes' do
    Post.create!(@valid_attributes)
  end

  it 'should recognize that a user has alrady cheered a post' do
    posts(:vino_hi).should be_cheered_by(users(:nilbus))
    posts(:vino_hi).should_not be_cheered_by(users(:admin))
  end

  it 'should require content' do
    p = Post.create
    p.should_not be_valid
  end

  it 'should scope posts with newest first' do
    Post.newest_first.should eql(Post.all.sort_by{|p|p.created_at}.reverse)
  end

  it 'should scope root posts' do
    Post.roots.each do |p|
      p.parent_id.should be_nil
    end
  end

  it 'should destroy cheers when destroyed' do
    cheers = posts(:vino_hi).cheers
    posts(:vino_hi).destroy
    cheers.each do |cheer|
      Cheer.find_by_id(cheer.id).should be_nil
    end
  end

  it 'should destroy associated replies when destroyed' do
    posts(:nilbus_welcome).should have(1).replies
    reply = posts(:nilbus_welcome).replies.first
    posts(:nilbus_welcome).destroy
    Post.find_by_id(reply.id).should be_nil
  end

  it 'should associate with its parent' do
    posts(:nilbus_reply).parent.should eql(posts(:nilbus_welcome))
  end

end

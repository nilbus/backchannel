require 'spec_helper'

describe Cheer do
  fixtures :all

  before(:each) do
    @valid_attributes = {
      :user_id => users(:nilbus).id,
      :post_id => posts(:nilbus_welcome).id
    }
  end

  it "should create a new instance given valid attributes" do
    Cheer.create!(@valid_attributes)
  end
end

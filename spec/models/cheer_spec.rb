require 'spec_helper'

describe Cheer do
  before(:each) do
    @valid_attributes = {
      :user_id => 1,
      :post_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Cheer.create!(@valid_attributes)
  end
end

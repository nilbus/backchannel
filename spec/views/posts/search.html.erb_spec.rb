require 'spec_helper'

describe "/posts/search" do
  before(:each) do
    render 'posts/search'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p', %r[Find me in app/views/posts/search])
  end
end

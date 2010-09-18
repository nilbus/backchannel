class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent, :class_name => 'Post'
  has_many :replies, :class_name => 'Post', :foreign_key => 'parent_id', :dependent => :destroy
  has_many :cheers

  named_scope :roots, :conditions => { :parent_id => nil }

  validates_presence_of :content

  def cheered_by?(user)
    cheers.map(&:user).include? user
  end
end

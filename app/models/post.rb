class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent, :class_name => 'Post'
  has_many :replies, :class_name => 'Post', :foreign_key => 'parent_id'

  default_scope :order => 'created_at DESC'
  named_scope :roots, :conditions => { :parent_id => nil }

  validates_presence_of :content
end

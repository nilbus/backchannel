class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent, :class_name => 'Post'
  has_many :replies, :class_name => 'Post', :foreign_key => 'parent_id', :dependent => :destroy
  has_many :cheers, :dependent => :destroy

  named_scope :roots, :conditions => { :parent_id => nil }, :include => [{:replies => :user}, :user]
  named_scope :newest_first, :order => 'created_at desc'
  named_scope :with_cheers, :include => [:cheers, {:replies => :cheers}]

  validates_presence_of :content

  def cheered_by?(user)
    cheers.map(&:user_id).include? user.id
  end
end

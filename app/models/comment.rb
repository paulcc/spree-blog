class Comment < ActiveRecord::Base
  belongs_to :blog_entry
  belongs_to :user
 
  validates_presence_of :name
  validates_presence_of :user_id
  validates_presence_of :body

  # before_save :expand_uri

  named_scope :approved,     lambda {|*args| {:conditions => "approved == 't'"}}
  named_scope :not_approved, lambda {|*args| {:conditions => "approved != 't'"}}
  named_scope :lifo_order,   lambda {|*args| {:order => "created_at DESC"}}
  named_scope :date_order,   lambda {|*args| {:order => "created_at ASC"}}

  def self.latest	## keep?
      find(:all, :order => "created_at DESC", :limit => 3) # use lifo?
  end

  # check basic format of URIs, AND expand all non-blank uris to canonical form
  def validate
    unless self.uri.blank?
      self.uri = "http://#{self.uri}" unless URI.parse(self.uri).absolute? 
    end
  rescue
    errors.add(:uri, "malformed uri -- please check it")
  end
 
  private 
end

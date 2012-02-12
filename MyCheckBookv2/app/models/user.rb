class User < ActiveRecord::Base
  
  require 'digest'

  attr_accessor :password
  attr_protected :id
  
  # associations  
  has_many :transactions, :dependent => :destroy
  has_many :tags, :dependent => :destroy
  
  # validations
  validates_presence_of :username, :password
  #validates_presence_of :password, :if => :password_required?
  
  validates_length_of :username, :within => 6..20, :message => 'Username must be at least 6 characters long.'
  validates_length_of :password, :within => 8..50, :message => 'Password must be at least 8 characters long.'
  
  
  validates_uniqueness_of :username, :message => 'Username already taken.'
  validates_confirmation_of :password
  
  before_save :hash_new_password
  
  def self.authenticate(username, password)
    user = find_by_username(username)
    return user if user && user.authenticated?(password)
  end
  
  def authenticated?(password)
    self.hashed_password == hash(password)
  end
  
  protected    
    def hash_new_password
      return if password.blank?
      self.hashed_password = hash(password)
    end
    
    def password_required?
      hashed_password.blank? || password.present?
    end
    
    def hash(str)
      Digest::SHA1.hexdigest(str)
    end
  
end

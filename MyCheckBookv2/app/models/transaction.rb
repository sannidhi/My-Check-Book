class Transaction < ActiveRecord::Base
  
  # associations
  belongs_to :user
  has_and_belongs_to_many :tags
  
  #validations
  validates_presence_of :transaction_date, :amount, :description
  validates_inclusion_of :transaction_date, :in => (Date.today << 60)..(Date.today), 
    :message => 'Transaction date cannot be older than 5 years or beyond today.'
    
  validates_numericality_of :amount, :on => :create, :message => 'is not a number', :only_integer => true
  
  
  def self.search(userid, tagstring)
    
    puts "in model. userid = " + userid.to_s
    user = User.find(userid.to_i)
    if user.nil?
      return nil
    end
    
    puts "parsing: " + tagstring.to_s
    if tagstring && tagstring.strip.length != 0
      tags = tagstring.to_s.scan(/#\w+/)
      tags.each {|t| ((t.reverse!).chop!).reverse! }
      puts "tags = " + tags.to_s
      
      list = []
      puts "is nil? " + list.nil?.to_s
      tags.each { |tag| list.push(user.transactions.all(:include => :tags, :conditions => ["tags.tag_name like ?", tag])) }
      puts "now? " + list.nil?.to_s    
      list.flatten!
      list.uniq!
      
      return list
    end
    
    return user.transactions.all

  end

end
class Tag < ActiveRecord::Base
  
  # associations
  belongs_to :user
  has_and_belongs_to_many :transactions
  
  # validations
  validates_presence_of :tag_name, :message => "can't be blank"
end

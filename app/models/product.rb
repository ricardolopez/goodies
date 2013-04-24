class Product < ActiveRecord::Base
  
  belongs_to :user

  attr_accessible :date, :description, :name, :price, :user_id, :view_count

  validates_presence_of :description
  validates_presence_of :name
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}

end

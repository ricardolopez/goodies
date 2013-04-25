class Product < ActiveRecord::Base
  
  belongs_to :user

  before_save :default_values

  attr_accessible :date, :description, :name, :price, :user_id, :view_count

  validates_presence_of :description
  validates_presence_of :name
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}

  private

  def default_values
  	self.view_count ||= 0
  end

end

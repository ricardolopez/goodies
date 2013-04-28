class Product < ActiveRecord::Base
  
  belongs_to :user

  before_save :default_values

  attr_accessible :date, :description, :name, :price, :user_id, :view_count, :avatar

  attr_accessor :avatar

  has_attached_file :avatar,
                      :path => "cs446/rlopez/#{Rails.env}:url",
                      :styles => { :thumb => "140x140>", :medium => "200x200>", :large => "250x250>" }

  validates_presence_of :description
  validates_presence_of :name
  validates :avatar, :attachment_presence => true
  validates :price, :presence => true, :numericality => {:greater_than_or_equal_to => 0.01},
    :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }

  private

  def default_values
  	self.view_count ||= 0
  end

end

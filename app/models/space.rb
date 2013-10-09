class Space < ActiveRecord::Base
  has_paper_trail
  acts_as_gmappable

  before_update :update_lat_lng

  attr_accessor :dot_color

  def self.categories
    # Downcased and capitalized for great justice
    Space.all.select(:category).map{|s| s.category.downcase.capitalize }.uniq
  end

  def self.dot_colors
    ["red","blue","green","yellow","purple","orange"]
  end

  def website_with_protocol
    /^http/.match(self.website) ? self.website : "http://#{self.website}"
  end

  def full_address
    "#{self.address}, #{self.city} #{self.state}" 
  end

  def gmaps4rails_address
    #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    self.full_address
  end

  def update_lat_lng
    coords = self.geocode.first
    Rails.logger.info coords.inspect
    self.latitude = coords[:lat]
    self.longitude = coords[:lng]
  end

  def geocode
    Gmaps4rails.geocode(self.full_address)
  end
end

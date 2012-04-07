class Route < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :departure_lat, :departure_lng, :arrival_lat, :arrival_lng
  
  
end

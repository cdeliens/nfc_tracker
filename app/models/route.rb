class Route < ActiveRecord::Base
  has_many :points

  def polyline_route
    points = self.points.map { |i| [i[:latitude], i[:longitude]]}
    Polylines::Encoder.encode_points(points)
  end


  def self.clean_route route_name
    points_recorded = $redis.keys "NFC_Tracker_#{route_name}.*"
    $redis.del points_recorded
  end

end

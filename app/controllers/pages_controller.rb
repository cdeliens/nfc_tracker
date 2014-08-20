class PagesController < ApplicationController
  def index
    points_recorded = $redis.keys "NFC_Tracker_Route_A.*"
    if points_recorded.count > 0
      @route = get_routes points_recorded 
    else
      if params[:id]
        @route = Route.find_by_card_id params[:id]
      else
        @route = Route.last
      end
    end
    @polylines = []
    Point.where(route_id: @route.id).order(:position).each do |point| 
      @polylines << [point.latitude, point.longitude] 
    end
    @polylines = @polylines.to_s

    @first_place = Route.last
    Route.all.each do |route|
      @first_place = route if route.points.count > @first_place.points.count
    end

    
    respond_to do |format|
      format.html 
      format.js {render layout: false}
    end

  end



  private 


  def get_routes points_recorded
    card_information_array = []
    @cards_read = points_recorded.map do |card_key|
      card_information = eval $redis.get card_key
      @route = Route.find_or_create_by name: card_information[:name], card_id: card_information[:id]
      point = Point.find_or_create_by(ip: card_information[:ip], route: @route, latitude: card_information[:latitude], longitude: card_information[:longitude], time: card_information[:time], position: card_information[:position])
      $redis.del card_key
    end
    @route
  end

end

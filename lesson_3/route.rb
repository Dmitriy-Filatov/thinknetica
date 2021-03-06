# frozen_string_literal: true

require_relative 'station'

class Route
  attr_reader :first_station, :last_station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @middle_stations = []
  end

  def get_station(station)
    @middle_stations << station
  end

  def delete_station(station)
    @middle_stations.delete(station)
  end

  def stations
    [@first_station, *@middle_stations, @last_station]
  end

  def name
    "#{@first_station.name} - #{@last_station.name}"
  end
end

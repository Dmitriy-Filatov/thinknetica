# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'validation'
require_relative 'station'

class Route
  extend Accessors
  include InstanceCounter
  include Validation

  attr_accessor_with_history :stations
  attr_reader :first_station, :last_station

  validate :stations, :presence
  validate :stations, :type, Array

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @middle_stations = []
    validate!
    register_instance
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

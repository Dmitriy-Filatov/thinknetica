# frozen_string_literal: true

require_relative 'company_name'
require_relative 'instances_counter'
require_relative 'validate'

class Train
  include CompanyName
  include InstanceCounter
  include Validate

  NUMBER_FORMAT = /^[[a-z]\d]{3}+-*+[[a-z]\d]{2}$/i

  @all_trains = []

  class << self
    def add_train=(object)
      @all_trains << object
    end

    def find(number)
      @all_trains.detect { |train| train.number == number }
    end
  end

  attr_reader :number, :type, :railcars, :speed, :route
  attr_writer :number, :type

  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @railcars = []
    self.class.add_train = self
    validate!
    register_instance
  end

  def to_accelerate(value)
    @speed += value
  end

  def current_speed
    @speed
  end

  def stop
    @speed = 0
  end

  def hitch_a_railcar(railcar)
    return if !@speed.zero? || @type != railcar.type

    @railcars << railcar
  end

  def uncouple_a_railcar(railcar)
    @railcars.delete(railcar) if @speed.zero? && @type == railcar.type
  end

  def assign_route(route)
    @route = route
    set_train_to_first_station
  end

  def set_train_to_first_station
    @route.first_station.add_train(self)
  end

  def move_to_next_station
    next_station.add_train(self)
    current_station.send_train(self)
  end

  def move_to_previous_station
    previous_station.add_train(self)
    current_station.send_train(self)
  end

  protected

  def current_station
    @route.stations.detect do |station|
      station.trains.include?(self)
    end
  end

  def next_station
    current_station_index = @route.stations.index(current_station)
    next_station_index = current_station_index + 1
    @route.stations[next_station_index]
  end

  def previous_station
    current_station_index = @route.stations.index(current_station)
    previous_station_index = current_station_index - 1
    @route.stations[previous_station_index]
  end

  def validate!
    raise "Number can't be nil" if number.nil?
    raise "Type can't be empty" if type.empty?
    raise "Number has invalid format. Expected: xxx-xx or xxxxx" if number !~ NUMBER_FORMAT
  end
end

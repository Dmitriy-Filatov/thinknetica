# frozen_string_literal: true

class Train
  attr_accessor :speed
  attr_reader :number, :type, :railcars, :route

  def initialize(number)
    @number = number
    @type = type
    @speed = 0
    @railcars = []
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
    return unless @speed.zero?

    @railcars << railcar
  end

  def uncouple_a_railcar
    @railcars.pop if @speed.zero? && !@railcars.empty?
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

  # методы ниже унаследованы подклассами

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
end

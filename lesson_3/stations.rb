# frozen_string_literal: true

class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def send_train(train)
    trains.delete(train)
  end
end

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

  # def uncouple_a_railcar
  #   @how_many_railcars -= 1 if @speed.zero? && @how_many_railcars.positive?
  # end

  def assign_route(route)
    @route = route
    set_train_to_first_station
  end

  def hitch_a_railcar(railcar)
    return if @speed.zero?

    @railcars << railcar
  end

  def set_train_to_first_station
    @route.first_station.add_train(self)
  end

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

  def move_to_next_station
    next_station.get_train(self)
    current_station.send_train(self)
  end

  def move_to_previous_station
    previous_station.get_train(self)
    current_station.send_train(self)
  end
end

class PassengerTrain < Train
  def hitch_a_railcar(railcar)
    return unless railcar.is_a?(PassengerRailcar)

    super(railcar)
  end
end

class CargoTrain < Train
  def hitch_a_railcar(railcar)
    return unless railcar.is_a?(CargoRailcar)

    super(railcar)
  end
end

class RailCar
  attr_reader :type

  def initialize(type)
    @type = type
  end
end

class PassengerRailcar < RailCar
  def initialize
    @type = 'passanger'
  end
end

class CargoRailcar < RailCar
  def initialize
    @type = 'cargo'
  end
end

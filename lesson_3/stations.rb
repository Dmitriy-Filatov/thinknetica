class Station
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def get_train(train)
    @trains << train
  end

  def return_trains_list(type)
    trains.select { |train| train.train_type == type }
  end

  def send_train(train)
    trains.delete(train)
  end

end

class Route
  attr_reader :stations, :first_station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @middle_stations = []
    @stations = [@first_station, *@middle_stations, @last_station]
  end

  def get_station(station)
    @middle_stations << station
  end

  def delete_station(station)
    @middle_stations.delete(station)
  end

  def all_stations
    puts [@first_station, *@middle_stations, @last_station]
  end
end

class Train
  attr_accessor :speed
  attr_reader :number, :train_type, :how_many_railcars

  def initialize(number, train_type, how_many_railcars)
    @number = number
    @train_type = train_type
    @how_many_railcars = how_many_railcars
    @speed = 0
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

  def hitch_a_railcar
    @how_many_railcars += 1 if @speed.zero?
  end

  def uncouple_a_railcar
    @how_many_railcars -= 1 if @speed.zero? && @how_many_railcars > 0
  end

  def set_route(route)
    @route = route
    set_train_to_first_station
  end

  def set_train_to_first_station
    @route.first_station.get_train(self)
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

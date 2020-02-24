require 'pry'
require_relative 'stations'

class Main
  def initialize
    @stations = []
    @trains = []
    @routes = []
    @railcars = []
  end

  def call
    loop do
      print_menu
      menu_number = gets.chomp
      break if menu_number == '0'
      detect_user_input(menu_number)
    end
  end

  def detect_user_input(menu_number)
    case menu_number
    when '1'
      create_station
    when '2'
      create_train
    when '3'
      create_route
    when '4'
      add_station_to_the_route
    when '5'
      delete_station_from_the_route
    when '6'
      set_a_train_route
    when '7'
      hook_the_railcar_to_the_train
    when '8'
      unhook_the_railcar_from_the_train
    when '9'
      move_to_next_station
    when '10'
      move_to_previous_station
    when '11'
      view_station_list
    when '12'
      view_the_list_of_the_trains_at_the_station
    end
  end

  def create_station
    puts 'Введите название станции'
    station_name = gets.chomp
    @stations << Station.new(station_name)
    puts 'Станции:'
    puts @stations.map(&:name)
  end

  def create_train
    puts 'Введите 1, если поезд грузовой, 2, если пассажирский'
    number = gets.chomp
    train =
      case number
      when '1'
        puts 'Введите номер поезда'
        number = gets.chomp
        CargoTrain.new(number)
      when '2'
        puts 'Введите номер поезда'
        number = gets.chomp
        PassengerTrain.new(number)
      else
        puts 'Неверное значение'
      end
    @trains << train if train
  end

  def create_route
    puts 'Выберете название станций из списка'
    puts @stations.map(&:name)
    puts 'Введите название первой станции'
    first_station_name = gets.chomp
    first_station = @stations.detect { |station| station.name == first_station_name}
    puts 'Введите название последней станции'
    last_station_name = gets.chomp
    last_station = @stations.detect { |station| station.name == last_station_name}
    @routes << Route.new(first_station, last_station)
  end

  def add_station_to_the_route
    puts 'Введите название промежуточной станции'
    middle_station_name = gets.chomp
    @stations.insert(-2, Station.new(middle_station_name))
    puts 'Станции:'
    puts @stations.map(&:name)
    puts 'Введите маршрут'
    route = gets.chomp
    route.get_station(middle_station_name)
  end

  def delete_station_from_the_route

  end

  def set_a_train_route

  end

  def hook_the_railcar_to_the_train

  end

  def unhook_the_railcar_from_the_train

  end

  def move_to_next_station

  end

  def move_to_previous_station

  end

  def view_station_list

  end

  def view_the_list_of_the_trains_at_the_station

  end

  def print_menu
    puts 'Чтобы создать станцию введите 1'
    puts 'Чтобы создать поезда введите 2'
    puts 'Чтобы создать маршруты введите 3'
    puts 'Чтобы добавить станцию в маршрут введите 4'
    puts 'Чтобы удалить станцию из маршрута введите 5'
    puts 'Чтобы назначить маршрут поезду введите 6'
    puts 'Чтобы прицепить вагоны к поезду введите 7'
    puts 'Чтобы отцепить вагоны от поезда введите 8'
    puts 'Чтобы переместить поезд по маршруту вперед введите 9'
    puts 'Чтобы переместить поезд по маршруту назад введите 10'
    puts 'Чтобы просматривать список станций введите 11'
    puts 'Чтобы просматривать список поездов на станции ведите 12'
    puts 'Чтобы выйти из меню нажмите 0'
  end
end

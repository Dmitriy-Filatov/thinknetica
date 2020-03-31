# frozen_string_literal: true

require 'pry'
require_relative 'company_name'
require_relative 'instance_counter'
require_relative 'validate'
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'railcar'
require_relative 'passenger_railcar'
require_relative 'cargo_railcar'

class Main
  def initialize
    @stations = []
    @trains = []
    @routes = []
    @railcars = []
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

  def start
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
      move_to_next_station_forward
    when '10'
      move_to_previous_station_back
    when '11'
      view_station_list
    when '12'
      view_the_list_of_the_trains_at_the_station
    end
  end

  private

  # методы ниже вызываются только в текущем классе

  def create_station
    puts 'Создаём станции. Введите название станции.'
    station_name = gets.chomp
    @stations << Station.new(station_name)
    puts 'Созданы станции:'
    @stations.each.with_index(1) { |station, index| puts "#{index}. #{station.name}" }
  end

  def create_train
    puts 'Создаем поезда. Введите 1, если поезд грузовой, 2, если пассажирский.'
    number = gets.chomp
    train =
      case number
      when '1'
        puts 'Введите номер поезда.'
        number = gets.chomp
        CargoTrain.new(number)
      when '2'
        puts 'Введите номер поезда.'
        number = gets.chomp
        PassengerTrain.new(number)
      else
        puts 'Хм ... Введите 1, если поезд грузовой, 2, если пассажирский.'
      end
    @trains << train if train
    puts 'Созданы поезда:'
    @trains.each.with_index(1) { |train, index| puts "#{index}. #{train.number}" }
  end

  def create_route
    puts 'Создаем маршрут. Сначала введите номер станции отправления.'
    @stations.each.with_index(1) { |station, index| puts "#{index}. #{station.name}" }
    station_index = gets.to_i
    first_station = @stations[station_index - 1]
    puts 'Теперь введите номер станции прибытия.'
    @stations.each.with_index(1) { |station, index| puts "#{index}. #{station.name}" }
    station_index = gets.to_i
    last_station = @stations[station_index - 1]
    route = Route.new(first_station, last_station)
    @routes << route
    p "Маршрут #{route.name} создан."
  end

  def add_station_to_the_route
    puts 'Добавим в маршрут промежуточные станции. Введите номер маршрута.'
    @routes.each.with_index(1) { |route, index| puts "#{index}. #{route.name}" }
    route_index = gets.to_i
    route = @routes[route_index - 1]
    puts 'Введите номер промежуточной станции'
    puts 'Станции:'
    @stations.each.with_index(1) { |station, index| puts "#{index}. #{station.name}" }
    station_index = gets.to_i
    station = @stations[station_index - 1]
    route.get_station(station)
    puts "Станция #{station} добавлена в маршрут #{route.name}."
  end

  def delete_station_from_the_route
    puts 'Удалим станцию из маршрута. Сначала введите номер маршрута.'
    @routes.each.with_index(1) { |route, index| puts "#{index}. #{route.name}" }
    route_index = gets.to_i
    route = @routes[route_index - 1]
    puts 'Теперь введите номер удаляемой станции.'
    puts 'Станции:'
    @stations.each.with_index(1) { |station, index| puts "#{index}. #{station.name}" }
    station_index = gets.to_i
    station = @stations[station_index - 1]
    route.delete_station(station)
    puts "Станция #{station} удалена из маршрута #{route.name}."
  end

  def set_a_train_route
    puts 'Назначаем поезду маршрут. Сначала введите порядковый номер поезда.'
    @trains.each.with_index(1) { |train, index| puts "#{index}. #{train.number}" }
    train_index = gets.to_i
    train = @trains[train_index - 1]
    puts 'Теперь введите номер маршрута.'
    @routes.each.with_index(1) { |route, index| puts "#{index}. #{route.name}" }
    route_index = gets.to_i
    route = @routes[route_index - 1]
    train.assign_route(route)
    puts "Поезду номер #{train.number} назначен маршрут #{route.name}."
  end

  def hook_the_railcar_to_the_train
    puts 'Прицепляем вагон. Сначала введите назначенный поезду номер.'
    @trains.each { |train| puts train.number }
    number = gets.to_i
    train = @trains.detect { |train| train.number.to_i == number }
    train.hitch_a_railcar(RailCar.new(train.type))
    puts "В поезде #{train.number} - #{train.railcars.size} вагонов."
  end

  def unhook_the_railcar_from_the_train
    puts 'Отцепляем вагон. Сначала введите назначенный поезду номер.'
    @trains.each { |train| puts train.number }
    number = gets.to_i
    train = @trains.detect { |train| train.number.to_i == number }
    train.uncouple_a_railcar(train.railcars.last)
    puts "В поезде #{train.number} - #{train.railcars.size} вагонов."
  end

  def move_to_next_station_forward
    puts "Выбираем поезд: введите назначенный поезду номер."
    @trains.each { |train| puts train.number }
    number = gets.to_i
    train = @trains.detect { |train| train.number.to_i == number }
    train.move_to_next_station
    puts "Поезд прибыл на станцию #{train.current_station.name}"
  end

  def move_to_previous_station_back
    puts "Выбираем поезд: введите назначенный поезду номер."
    @trains.each { |train| puts train.number }
    number = gets.to_i
    train = @trains.detect { |train| train.number.to_i == number }
    train.move_to_previous_station
    puts "Поезд прибыл на станцию #{train.current_station.name}"
  end

  def view_station_list
    puts 'Cписок всех станций:'
    @stations.each.with_index(1) { |station, index| puts "#{index}. #{station.name}" }
  end

  def view_the_list_of_the_trains_at_the_station
    puts 'Смотрим список поездов. Введите порядковый номер станции.'
    @stations.each.with_index(1) { |station, index| puts "#{index}. #{station.name}" }
    station_index = gets.to_i
    station = @stations[station_index - 1]
    puts "На станции #{station.name} следующие поезда #{station.trains}"
  end
end

Main.new.start

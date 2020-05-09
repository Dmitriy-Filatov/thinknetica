# frozen_string_literal: true

require_relative 'validation'
require_relative 'railcar'

class PassengerRailcar < RailCar
  include Validation

  attr_reader :occupied_seats, :seats

  validate :seats, :presence
  validate :seats, :type, Integer

  def initialize(seats = 10)
    @seats = seats
    @occupied_seats = 0
    @type = 'passenger'
  end

  def take_seat
    return if vacant_seats < 1

    @occupied_seats += 1
  end

  def vacant_seats
    @seats - @occupied_seats
  end

  def validate!
    raise 'Количество мест должно быть больше нуля' if seats.zero?
  end
end

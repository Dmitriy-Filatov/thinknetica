# frozen_string_literal: true

require_relative 'railcar'

class PassengerRailcar < RailCar
  attr_reader :occupied_seats, :seats

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
end

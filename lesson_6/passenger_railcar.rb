# frozen_string_literal: true

class PassengerRailcar < RailCar
  def initialize
    @type = 'passenger'
    @total_seats = 100
  end

  def take_seat
  end

  def occupied_seats
  end

  def vacant_seats
  end
end

# frozen_string_literal: true

require_relative 'railcar'

class CargoRailcar < RailCar
  def initialize
    @type = 'cargo'
  end
end

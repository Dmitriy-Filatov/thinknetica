# frozen_string_literal: true

require_relative 'railcar'

class CargoRailcar < RailCar
  def initialize
    @type = 'cargo'
    @overall_volume = 1000
  end

  def take_up_space(volume)
  end

  def occupied_space(volume)
  end

  def empty_volume
  end
end

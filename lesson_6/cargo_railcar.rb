# frozen_string_literal: true

require_relative 'railcar'

class CargoRailcar < RailCar
  attr_reader :volume, :occupied_space

  def initialize(volume = 1000)
    @volume = volume
    @occupied_space = 0
    @type = 'cargo'
    validate!
  end

  def take_up_space(volume)
    return if volume > @volume

    @occupied_space += volume if empty_volume >= volume
  end

  def empty_volume
    @volume - @occupied_space
  end
end

# frozen_string_literal: true

require_relative 'validation'
require_relative 'railcar'

class CargoRailcar < RailCar
  include Validation

  attr_reader :volume, :occupied_space

  validate :volume, :presence
  validate :volume, :type, Integer

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

  def validate!
    raise 'Объем должен быть больше нуля' if overall_volume.zero?
  end
end

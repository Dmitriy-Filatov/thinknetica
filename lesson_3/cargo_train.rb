# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train
  def hitch_a_railcar
    super(CargoRailcar.new)
  end
end

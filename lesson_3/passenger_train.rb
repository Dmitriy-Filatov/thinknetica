# frozen_string_literal: true

require_relative 'train'

class PassengerTrain < Train
  def hitch_a_railcar
    super(PassengerRailcar.new)
  end
end

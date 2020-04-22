# frozen_string_literal: true

require_relative 'train'

class PassengerTrain < Train
  def initialize(number, type = 'passenger')
    super
  end
end

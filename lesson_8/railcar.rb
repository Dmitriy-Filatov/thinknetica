# frozen_string_literal: true

require_relative 'company_name'
require_relative 'validation'
require_relative 'train'

class RailCar
  include CompanyName
  include Validation

  attr_reader :type

  def info
    if @type == 'cargo'
      puts "Volume: #{@volume}."
      puts "Occupied_space: #{@occupied_space}."
      puts "Empty_volume #{@volume - @occupied_space}."
    else
      puts "Seats: #{@seats}."
      puts "Occupied_seats: #{@occupied_seats}."
      puts "Vacant seats: #{@seats - @occupied_seats}."
    end
  end
end

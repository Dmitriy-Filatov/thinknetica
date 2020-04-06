# frozen_string_literal: true

require_relative 'company_name'

class RailCar
  include CompanyName
  attr_reader :type

  def initialize(type)
    @type = type
  end
end

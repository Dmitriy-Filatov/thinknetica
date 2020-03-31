# frozen_string_literal: true

require_relative 'instances_counter'
require_relative 'validate'

class Station
  include InstanceCounter
  include Validate

  @all = []

  class << self
    attr_reader :all

    def all=(object)
      @all << object
    end
  end

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    self.class.all = self
    validate!
    register_instance
  end

  def add_train(train)
    @trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  protected

  attr_writer :name

  def validate!
    raise 'Name not entered' if name.empty?
    raise 'Name must not be longer than 40 symbols' if name.length > 40
  end
end

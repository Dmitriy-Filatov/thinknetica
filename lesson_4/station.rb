# frozen_string_literal: true

require_relative 'instance_counter'

class Station
  include InstanceCounter

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
  end

  def add_train(train)
    @trains << train
  end

  def send_train(train)
    trains.delete(train)
  end
end
